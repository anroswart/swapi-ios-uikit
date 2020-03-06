import Foundation
import UIKit.UIImage

class URLSessionMock: URLSession {
    var data: Data?
    var error: Error?
    var shouldInjectFilmData = false

    // dataTask that is used for fetching images
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if shouldInjectFilmData {
            injectImageData(forURL: url)
        }
        
        return URLSessionDataTaskMock {
            completionHandler(self.data, nil, self.error)
        }
    }
    
    private func injectImageData(forURL url: URL?) {
        if let url = url?.absoluteString, url.contains("image") {
            self.data = UIImage(named: "background", in: Bundle.main, compatibleWith: nil)?.pngData()
        }
    }
    
    // dataTask that is used for fetching film data
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if shouldInjectFilmData {
            injectFilmData(forURL: request.url)
            injectCharacterData(forURL: request.url)
            injectSearchData(forURL: request.url)
        }
        
        return URLSessionDataTaskMock {
            completionHandler(self.data, nil, self.error)
        }
    }
    
    private func injectFilmData(forURL url: URL?) {
        if let url = url?.absoluteString, url.contains("films") {
            self.data = MockHelpers.data(forResource: "SWAPIFilmsResponse")
        }
    }
    
    private func injectCharacterData(forURL url: URL?) {
        if let url = url?.absoluteString, url.contains("people") {
            self.data = MockHelpers.data(forResource: "people-\(url.characterNumber)")
        }
    }
    
    private func injectSearchData(forURL url: URL?) {
        if
            let url = url?.absoluteString, url.contains("search"),
            let start = url.range(of: "Star%20Wars:%20")?.upperBound,
            let end = url.range(of: "&language")?.lowerBound {
            
            let range = start..<end
            let substring = url[range]
            if let movieTitle = NSString(string: String(substring)).removingPercentEncoding {
                self.data = MockHelpers.data(forResource: movieTitle)
            }
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let completion: () -> Void

    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    override func resume() {
        completion()
    }
}
