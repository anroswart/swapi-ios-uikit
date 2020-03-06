@testable import mvvm_test_1

class FilmCacheInteractorTestingImplementation: FilmCacheInteractor {
    var didCallWriteFilms = false
    var didCallSortedFilms = false
    
    override func writeFilms(_ films: [Film]) {
        didCallWriteFilms = true
    }
    
    override func sortedFilms() -> [Film]? {
        didCallSortedFilms = true
        return nil
    }
}
