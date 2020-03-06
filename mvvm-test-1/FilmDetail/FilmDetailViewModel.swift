import Foundation

class FilmDetailViewModel: NSObject {
    var film: Film
    
    init(withFilm film: Film) {
        self.film = film
    }
    
    var filmRating: Double {
        (film.rating.value ?? 0) / 2
    }
    
    var filmCharacters: String {
        film.characterList.joined(separator: ", ")
    }
    
    var filmOpeningCrawl: String {
        guard let openingCrawl = film.openingCrawl else { return "" }
        let newLines = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        return "\(newLines)\(openingCrawl)"
    }
}
