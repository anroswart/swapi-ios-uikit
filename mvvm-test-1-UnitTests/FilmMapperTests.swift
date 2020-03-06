import XCTest
@testable import mvvm_test_1

enum ClientError: Error {
    case error
}

class FilmMapperTests: XCTestCase {
    // Made static to cater for class func setUp
    private static var session: URLSessionMock!
    private static var filmCache: FilmCacheInteractor!
    private static var serviceUnderTest: FilmMapper!

    // Made class func so it executes only once
    override class func setUp() {
        FilmMapperTests.session = URLSessionMock()
        FilmMapperTests.filmCache = FilmCacheInteractorTestingImplementation()
        FilmMapperTests.serviceUnderTest = FilmMapperTestingImplementation(withSWAPIClient: SWAPIClient(session: session), filmCache: FilmMapperTests.filmCache)
    }

    // The below numbered tests needs to be executed in succession
    func test_01_FetchFilmsReturnsTheExpecterNumberOfFilms() {
        fetchFilmsWithData()
        
        XCTAssertEqual(7, FilmMapperTests.serviceUnderTest.films.count)
    }
    
    func test_02_FilmANewHopeHasTheExpectedNumberOfCharacters() throws {
        let characters = try characterList(forTitle: "A New Hope")
        
        XCTAssertEqual(10, characters.count)
    }
    
    func test_03_FilmAttackOfTheClonesHasTheExpectedNumberOfCharacters() throws {
        let characters = try characterList(forTitle: "Attack of the Clones")
        
        XCTAssertEqual(5, characters.count)
    }
    
    func test_04_FilmThePhantomMenaceHasTheExpectedNumberOfCharacters() throws {
        let characters = try characterList(forTitle: "The Phantom Menace")
        
        XCTAssertEqual(3, characters.count)
    }
    
    func test_05_FilmRevengeOfTheSithHasTheExpectedNumberOfCharacters() throws {
        let characters = try characterList(forTitle: "Revenge of the Sith")
        
        XCTAssertEqual(8, characters.count)
    }
    
    func test_06_FilmReturnOfTheJediHasTheExpectedNumberOfCharacters() throws {
        let characters = try characterList(forTitle: "Return of the Jedi")
        
        XCTAssertEqual(6, characters.count)
    }
    
    func test_07_FilmTheEmpireStrikesBackHasTheExpectedNumberOfCharacters() throws {
        let characters = try characterList(forTitle: "The Empire Strikes Back")
        
        XCTAssertEqual(6, characters.count)
    }
    
    func test_08_FilmTheForceAwakensHasTheExpectedNumberOfCharacters() throws {
        let characters = try characterList(forTitle: "The Force Awakens")
        
        XCTAssertEqual(3, characters.count)
    }
    
    func test_09_FilmANewHopeHasRatingAndImageData() throws {
        let testFilm = try film(forTitle: "A New Hope")
        XCTAssertNotNil(testFilm.posterData)
        XCTAssertNotNil(testFilm.rating)
    }
    
    func test_10_FilmFilmAttackOfTheClonesHasRatingAndImageData() throws {
        let testFilm = try film(forTitle: "Attack of the Clones")
        XCTAssertNotNil(testFilm.posterData)
        XCTAssertNotNil(testFilm.rating)
    }
    
    func test_11_FilmThePhantomMenaceHasRatingAndImageData() throws {
        let testFilm = try film(forTitle: "The Phantom Menace")
        XCTAssertNotNil(testFilm.posterData)
        XCTAssertNotNil(testFilm.rating)
    }
    
    func test_12_FilmRevengeOfTheSithHasRatingAndImageData() throws {
        let testFilm = try film(forTitle: "Revenge of the Sith")
        XCTAssertNotNil(testFilm.posterData)
        XCTAssertNotNil(testFilm.rating)
    }
    
    func test_13_FilmReturnOfTheJediHasRatingAndImageData() throws {
        let testFilm = try film(forTitle: "Return of the Jedi")
        XCTAssertNotNil(testFilm.posterData)
        XCTAssertNotNil(testFilm.rating)
    }
    
    func test_14_FilmTheEmpireStrikesBackHasRatingAndImageData() throws {
        let testFilm = try film(forTitle: "The Empire Strikes Back")
        XCTAssertNotNil(testFilm.posterData)
        XCTAssertNotNil(testFilm.rating)
    }
    
    func test_15_FilmTheForceAwakensHasRatingAndImageData() throws {
        let testFilm = try film(forTitle: "The Force Awakens")
        XCTAssertNotNil(testFilm.posterData)
        XCTAssertNotNil(testFilm.rating)
    }
    
    func testCompletionIsCalledAndCacheIsAccessedOnError() throws {
        var clientError: Error?
        let expectation = self.expectation(description: "Fetching films")
        FilmMapperTests.session.error = ClientError.error
        FilmMapperTests.session.shouldInjectFilmData = false
        FilmMapperTests.serviceUnderTest.fetchFilms { (error) in
            clientError = error
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNotNil(clientError)
        XCTAssertTrue(try XCTUnwrap((FilmMapperTests.filmCache as? FilmCacheInteractorTestingImplementation)?.didCallSortedFilms))
    }
    
    func testFilmCacheWriteIsCalledOnSuccess() throws {
        fetchFilmsWithData()
        
        XCTAssertTrue(try XCTUnwrap((FilmMapperTests.filmCache as? FilmCacheInteractorTestingImplementation)?.didCallWriteFilms))
    }
    
    private func fetchFilmsWithData() {
        let expectation = self.expectation(description: "Fetching films")
        FilmMapperTests.session.error = nil
        FilmMapperTests.session.shouldInjectFilmData = true
        FilmMapperTests.serviceUnderTest.fetchFilms { (error) in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    private func characterList(forTitle title: String) throws -> [String] {
        return Array(try film(forTitle: title).characterURLs)
    }
    
    private func film(forTitle title: String) throws -> Film {
        return try XCTUnwrap(FilmMapperTests.serviceUnderTest.films.filter({ $0.title == title }).first)
    }
}
