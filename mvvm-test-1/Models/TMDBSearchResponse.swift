
struct TMDBSearchResponse: Decodable {
    let results: [TMDBSearchResult]
}

struct TMDBSearchResult: Decodable {
    let title: String
    let posterPath: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case rating = "vote_average"
    }
}
