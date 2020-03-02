
struct SWAPIFilmsResponse: Decodable {
    let count: Int
    let results: [Film]
}

struct SWAPICharacterResponse: Decodable {
    let name: String
}
