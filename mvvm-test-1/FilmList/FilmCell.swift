import UIKit

class FilmCell: UITableViewCell {
    @IBOutlet weak var filmPoster: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmReleaseDate: UILabel!
    @IBOutlet weak var filmDirectors: UILabel!
    @IBOutlet weak var filmProducers: UILabel!
    
    private lazy var placeholderPosterImage = UIImage(imageLiteralResourceName: "background")
    
    func configureCell(with film: Film?) {
        filmPoster.image = posterImageFromData(in: film)
        filmTitle.text = film?.title
        filmReleaseDate.text = film?.releaseDate
        filmDirectors.text = film?.director
        filmProducers.text = film?.producer
    }
    
    func posterImageFromData(in film: Film?) -> UIImage {
        if let data = film?.posterData, let posterImage = UIImage(data: data) {
            return posterImage
        }
        return placeholderPosterImage
    }
}
