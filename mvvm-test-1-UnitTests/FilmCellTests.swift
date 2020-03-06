import XCTest
@testable import mvvm_test_1
import UIKit

class FilmCellTests: XCTestCase {
    var serviceUnderTest: FilmCell!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FilmListViewController") as! FilmListViewController
        viewController.loadView()
        serviceUnderTest = viewController.tableViewFilms.dequeueReusableCell(withIdentifier: "filmCell") as? FilmCell
    }

    func testCellContentIsConfiguredCorrectly() {
        serviceUnderTest.configureCell(with: FilmMocks.aNewHope)
        
        XCTAssertNotNil(serviceUnderTest.filmPoster.image)
        XCTAssertEqual("A New Hope", serviceUnderTest.filmTitle.text)
        XCTAssertEqual("George Lucas", serviceUnderTest.filmDirectors.text)
        XCTAssertEqual("Gary Kurtz, Rick McCallum", serviceUnderTest.filmProducers.text)
        XCTAssertEqual("1977-05-25", serviceUnderTest.filmReleaseDate.text)
    }
    
    func testPlaceholderImageIsReturnedForNoImageData() {
        let mockFilm = FilmMocks.aNewHope
        mockFilm.posterData = nil
        serviceUnderTest.configureCell(with: mockFilm)
        XCTAssertNotNil(serviceUnderTest.filmPoster.image)
    }
}
