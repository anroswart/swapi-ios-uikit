import Foundation

class SWAPIClient: NSObject {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchFilms(completion: @escaping([Film]?, Error?) -> Void) {
        let filmsURL: String = "https://swapi.co/api/films/"
        getJSON(fromURL: filmsURL, withDecodableType: SWAPIFilmsResponse.self) { (responseObject, error) in
            completion(responseObject?.results, error)
        }
    }
    
    func fetchCharacters(characterURLs: [String], completion: @escaping(_ filmCharacters: [String]?, Error?)->()) {
        let group = DispatchGroup()
        var filmCharacterNames = [String]()
        for url in characterURLs {
            group.enter()
            getJSON(fromURL: url, withDecodableType: SWAPICharacterResponse.self) { (responseObject, error) in
                guard error == nil, let filmCharacter = responseObject?.name else { completion(nil, error); return }
                filmCharacterNames.append(filmCharacter)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(filmCharacterNames, nil)
        }
    }
    
    func fetchPostersAndRatings(forTitle title: String, completion: @escaping(_ imageData: Data?, _ rating: Double?, _ error: Error?) -> Void) {
        self.searchFilms(forTitle: title) { (filmMetadata, error) in
            guard let tmdbImageURL = filmMetadata?.posterPath, !tmdbImageURL.isEmpty else {
                completion(nil, filmMetadata?.rating, error)
                return
            }
            let urlString: String = "https://image.tmdb.org/t/p/w500\(tmdbImageURL)"
            guard let url = URL(string: urlString) else { return }
            self.session.dataTask(with: url, completionHandler: { (posterImageData, response, error) in
                completion(posterImageData, filmMetadata?.rating, error)
            }).resume()
        }
    }
    
    // Search for specific film to capture poster url and rating
    func searchFilms(forTitle title: String, completion: @escaping(TMDBSearchResult?, Error?) -> Void) {
        let title = "Star Wars: \(title)"
        guard let movieTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let tmdbURLString: String = "https://api.themoviedb.org/3/search/movie?include_adult=false&query=\(movieTitle)&language=en-US&api_key=026ed4b253a6531903d424d2f2008911"
        getJSON(fromURL: tmdbURLString, withDecodableType: TMDBSearchResponse.self) { (responseObject, error) in
            let validObjects = responseObject?.results.filter { $0.posterPath != nil }
            completion(validObjects?.first, error)
        }
    }
    
    func getJSON<T: Decodable>(fromURL urlString: String, withDecodableType: T.Type, completion: @escaping(_ responseObject: T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { print("Failed to create URL with string: \(urlString)"); return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        self.session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil, let data = data else {
                print("DataTask failed for \(urlString). \nError: \(String(describing: error))")
                completion(nil, error)
                return
            }
            do {
                let responseObject = try
                    JSONDecoder().decode(T.self, from: data)
                completion(responseObject, nil)
            } catch let decodingError {
                print("Decoding JSON failed:", decodingError)
                completion(nil, nil)
            }
        }.resume()
    }
}
