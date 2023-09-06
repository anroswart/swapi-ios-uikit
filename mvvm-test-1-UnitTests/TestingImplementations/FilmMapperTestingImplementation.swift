@testable import mvvm_test_1

class FilmMapperTestingImplementation: FilmService {
    override var films: [Film] {
        didSet {
            removeSomeCharacters()
        }
    }
    
    private func removeSomeCharacters() {
        for (index, film) in films.enumerated() {
            let newCharacterURLs = Array(film.characterURLs).filter {
                return $0.characterNumber <= 10
            }
            films[index].characterURLs.removeAll()
            films[index].characterURLs.append(objectsIn: newCharacterURLs)
        }
    }
}
