import Foundation

class SWAPIService: NSObject {
    private let baseURL = "https://swapi.co/api/"
    
    func fetchFilms(completion: @escaping([Film]?, Error?) -> Void) {
        let filmsURL: String = "\(self.baseURL)films/"
        getJSON(fromURL: filmsURL, withDecodableType: SWAPIFilmsResponse.self) { (responseObject, error) in
            completion(responseObject?.results, error)
        }
    }
    
    func fetchCharacters(characterURLs: [String], completion: @escaping(_ filmCharacters: [String]?, Error?)->()) {
        // Using Grand Central Dispatch for array of character URLs
        let group = DispatchGroup()
//        let serialQueue = DispatchQueue(label: "serialQueue")
        var filmCharacterNames = [String]()
        
        for url in characterURLs {
            group.enter()
            getJSON(fromURL: url, withDecodableType: SWAPICharacterResponse.self) { (responseObject, error) in
                guard error == nil, let filmCharacter = responseObject?.name else { completion(nil, error); return }
//                serialQueue.async {
                    filmCharacterNames.append(filmCharacter)
                    group.leave()
//                }
            }
        }
        
        group.notify(queue: .main) {
            completion(filmCharacterNames, nil)
        }
    }
    
    func getJSON<T: Decodable>(fromURL urlString: String, withDecodableType: T.Type, completion: @escaping(_ responseObject: T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { print("Failed to create URL with string: \(urlString)"); return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
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
