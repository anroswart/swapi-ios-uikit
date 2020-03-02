import XCTest
@testable import mvvm_test_1

class FilmMapperTests: XCTestCase {
    
    let serviceUnderTest = FilmMapper(withService: SWAPIServiceMock())

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test() {
        
    }
}

class SWAPIServiceMock: SWAPIService {
    var lastURL: String!
    
    override func getJSON<T: Decodable>(fromURL urlString: String, withDecodableType: T.Type, completion: @escaping(_ responseObject: T?, Error?) -> Void) {
        lastURL = urlString
    }
}
