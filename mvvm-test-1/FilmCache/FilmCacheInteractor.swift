import RealmSwift

class FilmCacheInteractor {
    private lazy var realm: Realm? = {
        do {
            return try Realm()
        } catch let error as NSError {
            print("Error in default cache: \(error)")
            return nil
        }
    }()
    
    func writeFilm(_ films: [Film]) {
        if let realm = realm {
            do {
                try realm.write {
//                    realm.deleteAll()
                    realm.add(films, update: .modified)
                }
            } catch let error as NSError {
                print("Error writing film to cache: \(error)")
            }
        }
    }
    
    func sortedFilms() -> [Film]? {
        if let realm = realm {
            return Array(realm.objects(Film.self)).sorted {
                guard let firstDate = $0.releaseDate, let secondDate = $1.releaseDate else { return false }
                return firstDate < secondDate
            }
        }
        return nil
    }
}
