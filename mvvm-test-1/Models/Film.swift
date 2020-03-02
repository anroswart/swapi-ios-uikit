import UIKit.UIImage
import RealmSwift

class Film: Object, Decodable {
    @objc dynamic var title: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var director: String?
    @objc dynamic var producer: String?
    @objc dynamic var openingCrawl: String?
    var characterURLs = List<String>()
    var characterList = List<String>()
    var rating = RealmOptional<Double>()
    @objc dynamic var posterData: Data?
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case director
        case producer
        case openingCrawl = "opening_crawl"
        case charactersURLs = "characters"
    }
    
    convenience init(title: String?, releaseDate: String?, director: String?, producer: String?, openingCrawl: String?, characterURLs:[String]?) {
        self.init()
        self.title = title
        self.releaseDate = releaseDate
        self.director = director
        self.producer = producer
        self.openingCrawl = openingCrawl
        self.characterURLs.append(objectsIn: characterURLs ?? [])
    }
    
    convenience required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decodeIfPresent(String.self, forKey: .title)
        let releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        let director = try container.decodeIfPresent(String.self, forKey: .director)
        let producer = try container.decodeIfPresent(String.self, forKey: .producer)
        let openingCrawl = try container.decodeIfPresent(String.self, forKey: .openingCrawl)
        let characterURLs = try container.decodeIfPresent([String].self, forKey: .charactersURLs)
        
        self.init(title: title, releaseDate: releaseDate, director: director, producer: producer, openingCrawl: openingCrawl, characterURLs: characterURLs)
    }
    
    override static func primaryKey() -> String? {
        return "releaseDate"
    }
}
