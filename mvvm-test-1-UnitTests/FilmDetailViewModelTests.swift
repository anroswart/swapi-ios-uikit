import XCTest
@testable import mvvm_test_1
import RealmSwift

class FilmDetailViewModelTests: XCTestCase {
    var serviceUnderTest: FilmDetailViewModel!

    override func setUp() {
        self.serviceUnderTest = FilmDetailViewModel(withFilm: FilmMocks.aNewHope)
    }

    func testFilmRating() {
        XCTAssertEqual(4.1, serviceUnderTest.filmRating)
    }
    
    func testFilmRatingForNilValue() {
        serviceUnderTest.film.rating = RealmOptional<Double>(nil)
        XCTAssertEqual(0, serviceUnderTest.filmRating)
    }
    
    func testFilmCharactersString() {
        let mockCharactersString = "Luke Skywalker, C-3PO, R2-D2, Darth Vader, Leia Organa, Owen Lars, Beru Whitesun lars, R5-D4, Biggs Darklighter, Obi-Wan Kenobi"
        XCTAssertEqual(mockCharactersString, serviceUnderTest.filmCharacters)
    }
    
    func testFilmOpeningCrawlString() {
        let newLines = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        XCTAssertEqual("\(newLines)\(serviceUnderTest.film.openingCrawl ?? "")", serviceUnderTest.filmOpeningCrawl)
    }
    
    func testFilmOpeningCrawlForNilValue() {
        serviceUnderTest.film.openingCrawl = nil
        XCTAssertTrue(serviceUnderTest.filmOpeningCrawl.isEmpty)
    }
}
