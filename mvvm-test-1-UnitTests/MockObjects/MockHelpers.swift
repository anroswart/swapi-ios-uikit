import Foundation

class MockHelpers {
    static func data(forResource resource: String) -> Data? {
        if let path = Bundle.init(for: self).path(forResource: resource, ofType: "json") {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch let error {
                print("Error when fetching data for resource \(resource): \nError: \(error)")
                return nil
            }
        }
        return nil
    }
}
