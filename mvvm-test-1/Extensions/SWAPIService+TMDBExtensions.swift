import UIKit.UIImage

extension SWAPIService {
    
    func getPostersAndRatings(forTitle title: String, completion: @escaping(_ imageData: Data?, _ rating: Double?, _ error: Error?) -> Void) {
        self.searchFilms(forTitle: title) { (filmMetadata, error) in
            guard let tmdbImageURL = filmMetadata?.posterPath, !tmdbImageURL.isEmpty else {
                completion(nil, filmMetadata?.rating, error)
                return
            }
            let urlString: String = "https://image.tmdb.org/t/p/w500\(tmdbImageURL)"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url, completionHandler: { (posterImageData, response, error) in
                completion(posterImageData, filmMetadata?.rating, error)
            }).resume()
        }
    }
    
    // Search for specific film to capture poster and rating
    func searchFilms(forTitle title: String, completion: @escaping(_ searchResponse: TMDBSearchResult?, _ error: Error?) -> Void) {
        let title = "Star Wars \(title)"
        guard let movieTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let tmdbURLString: String = "https://api.themoviedb.org/3/search/movie?include_adult=false&query=\(movieTitle)&language=en-US&api_key=026ed4b253a6531903d424d2f2008911"
        
        getJSON(fromURL: tmdbURLString, withDecodableType: TMDBSearchResponse.self) { (responseObject, error) in
            completion(responseObject?.results.first, error)
        }
    }
}
