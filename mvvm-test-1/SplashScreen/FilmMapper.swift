import Foundation
import RealmSwift

class FilmMapper: NSObject {
    private var swapiClient: SWAPIClient
    private var filmCache: FilmCacheInteractor
    var films = [Film]()
    
    init(withSWAPIClient swapiClient: SWAPIClient = SWAPIClient(), filmCache: FilmCacheInteractor = FilmCacheInteractor()) {
        self.swapiClient = swapiClient
        self.filmCache = filmCache
    }
    
    func fetchFilms(completion: @escaping (Error?) -> Void) {
        swapiClient.fetchFilms { (films, error) in
            guard error == nil, let films = films else {
                self.tryToRetrieveFilmsFromCache(networkError: error, withCompletion: completion)
                return
            }
            self.films = films.sorted {
                guard let firstDate = $0.releaseDate, let secondDate = $1.releaseDate else { return false }
                return firstDate < secondDate
            }
            self.getFilmsCharactersAndDoPosterCall(withCompletion: completion)
        }
    }
    
    private func tryToRetrieveFilmsFromCache(networkError: Error?, withCompletion completion: @escaping (Error?) -> Void) {
        print("Unable to retieve films, trying cache")
        DispatchQueue.main.async {
            if let films = self.filmCache.sortedFilms(), films.count > 0 {
                self.films = films
                completion(nil)
            } else {
                completion(networkError)
            }
        }
    }
    
    private func getFilmsCharactersAndDoPosterCall(withCompletion completion: @escaping (Error?) -> Void) {
        let charactersDispatchGroup = DispatchGroup()
        for (index, film) in self.films.enumerated() {
            charactersDispatchGroup.enter()
            guard film.characterURLs.count > 0 else { charactersDispatchGroup.leave(); continue }
            self.swapiClient.fetchCharacters(characterURLs: Array(film.characterURLs)) { (filmCharacters, error) in
                guard error == nil, let characters = filmCharacters else { charactersDispatchGroup.leave(); return }
                DispatchQueue.main.async { self.films[index].characterList.append(objectsIn: characters) }
                charactersDispatchGroup.leave()
            }
        }
        charactersDispatchGroup.notify(queue: .main) {
            self.getFilmsPostersAndRatings(withCompletion: completion)
        }
    }
    
    private func getFilmsPostersAndRatings(withCompletion completion: @escaping (Error?) -> Void) {
        let filmPosterDispatchGroup = DispatchGroup()
        for (index, film) in self.films.enumerated() {
            filmPosterDispatchGroup.enter()
            guard let title = film.title else { filmPosterDispatchGroup.leave(); continue }
            self.swapiClient.fetchPostersAndRatings(forTitle: title) { (filmPosterData, rating, error) in
                guard error == nil else { filmPosterDispatchGroup.leave(); return }
                self.films[index].posterData = filmPosterData
                self.films[index].rating.value = rating
                filmPosterDispatchGroup.leave()
            }
        }
        filmPosterDispatchGroup.notify(queue: .main) {
            self.filmCache.writeFilms(self.films)
            completion(nil)
        }
    }
}
