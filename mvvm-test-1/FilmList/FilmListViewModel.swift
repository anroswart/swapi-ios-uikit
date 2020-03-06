import Foundation
import UIKit.UIImage

class FilmListViewModel: NSObject {
    var films: [Film]
    
    init(films: [Film]) {
        self.films = films
    }
    
    func numberOfFilmsToDisplay(in section: Int) -> Int {
        return films.count
    }
    
    func filmToDisplay(at indexPath: IndexPath) -> Film {
        return films[indexPath.row]
    }
}
