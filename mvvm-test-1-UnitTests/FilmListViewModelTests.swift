import XCTest
@testable import mvvm_test_1
import RealmSwift

class FilmListViewModelTests: XCTestCase {
    private var session: URLSessionMock!
    private var filmMapper: FilmMapper!
    private var serviceUnderTest: FilmListViewModel!

    override func setUp() {
        session = URLSessionMock()
        filmMapper = FilmMapperTestingImplementation(withSWAPIClient: SWAPIClient(session: session), filmCache: FilmCacheInteractorTestingImplementation())
        fetchFilmsWithData()
        serviceUnderTest = FilmListViewModel(films: filmMapper.films)
    }
    
    private func fetchFilmsWithData() {
        let expectation = self.expectation(description: "Fetching films")
        session.error = nil
        session.shouldInjectFilmData = true
        filmMapper.fetchFilms { (error) in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testNumberOfFilmsToDisplayInSection0IsEqualToFilmsReturnedByService() {
        XCTAssertEqual(filmMapper.films.count, serviceUnderTest.numberOfFilmsToDisplay(in: 0))
    }
    
    func testFilmToDisplayForItem0() {
        let testFilm = serviceUnderTest.filmToDisplay(at: IndexPath(item: 0, section: 0))
        
        XCTAssertEqual(FilmMocks.aNewHope.title, testFilm.title)
        XCTAssertEqual(FilmMocks.aNewHope.releaseDate, testFilm.releaseDate)
        XCTAssertEqual(FilmMocks.aNewHope.director, testFilm.director)
        XCTAssertEqual(FilmMocks.aNewHope.producer, testFilm.producer)
        XCTAssertEqual(FilmMocks.aNewHope.openingCrawl, testFilm.openingCrawl)
        XCTAssertTrue(FilmMocks.aNewHope.characterURLs.elementsEqual(testFilm.characterURLs))
        XCTAssertTrue(FilmMocks.aNewHope.characterList.elementsEqual(testFilm.characterList))
        XCTAssertEqual(FilmMocks.aNewHope.rating.value, testFilm.rating.value)
        XCTAssertEqual(FilmMocks.aNewHope.posterData, testFilm.posterData)
    }
    
    func testFilmToDisplayForItem1() {
        let testFilm = serviceUnderTest.filmToDisplay(at: IndexPath(item: 1, section: 0))
        
        XCTAssertEqual(FilmMocks.theEmpireStrikesBack.title, testFilm.title)
        XCTAssertEqual(FilmMocks.theEmpireStrikesBack.releaseDate, testFilm.releaseDate)
        XCTAssertEqual(FilmMocks.theEmpireStrikesBack.director, testFilm.director)
        XCTAssertEqual(FilmMocks.theEmpireStrikesBack.producer, testFilm.producer)
        XCTAssertEqual(FilmMocks.theEmpireStrikesBack.openingCrawl, testFilm.openingCrawl)
        XCTAssertTrue(FilmMocks.theEmpireStrikesBack.characterURLs.elementsEqual(testFilm.characterURLs))
        XCTAssertTrue(FilmMocks.theEmpireStrikesBack.characterList.elementsEqual(testFilm.characterList))
        XCTAssertEqual(FilmMocks.theEmpireStrikesBack.rating.value, testFilm.rating.value)
        XCTAssertEqual(FilmMocks.theEmpireStrikesBack.posterData, testFilm.posterData)
    }
    
    func testFilmToDisplayForLastItem() {
        let testFilm = serviceUnderTest.filmToDisplay(at: IndexPath(item: filmMapper.films.count - 1, section: 0))
        
        XCTAssertEqual(FilmMocks.theForceAwakens.title, testFilm.title)
        XCTAssertEqual(FilmMocks.theForceAwakens.releaseDate, testFilm.releaseDate)
        XCTAssertEqual(FilmMocks.theForceAwakens.director, testFilm.director)
        XCTAssertEqual(FilmMocks.theForceAwakens.producer, testFilm.producer)
        XCTAssertEqual(FilmMocks.theForceAwakens.openingCrawl, testFilm.openingCrawl)
        XCTAssertTrue(FilmMocks.theForceAwakens.characterURLs.elementsEqual(testFilm.characterURLs))
        XCTAssertTrue(FilmMocks.theForceAwakens.characterList.elementsEqual(testFilm.characterList))
        XCTAssertEqual(FilmMocks.theForceAwakens.rating.value, testFilm.rating.value)
        XCTAssertEqual(FilmMocks.theForceAwakens.posterData, testFilm.posterData)
    }
}
