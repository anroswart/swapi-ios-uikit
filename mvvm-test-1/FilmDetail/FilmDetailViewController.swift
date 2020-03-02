import UIKit
import Cosmos
import StarWarsTextView

class FilmDetailViewController: UIViewController {
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmReleaseDate: UILabel!
    @IBOutlet weak var filmCharacters: UITextView!
    @IBOutlet weak var filmRating: CosmosView!
    @IBOutlet weak var filmCrawlingTextPlaceholder: UIView!
    
    var filmCrawlingText: StarWarsTextView = {
        let textView = StarWarsTextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .black
        textView.textColor = .yellow
        textView.textAlignment = .center
        return textView
    }()
    
    var viewModel: FilmDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Star Wars"
        navigationController?.view.backgroundColor = .black
        filmCrawlingText.starWarsDelegate = self
        configureViewContents()
        configureFilmCrawlingText()
    }
    
    func configureViewContents() {
        filmTitle.text = viewModel?.film.title
        filmReleaseDate.text = viewModel?.film.releaseDate
        filmCharacters.text = viewModel?.filmCharacters
        filmCrawlingText.text = viewModel?.filmOpeningCrawl
        filmRating.rating = viewModel?.filmRating ?? 0
    }
    
    private func configureFilmCrawlingText() {
        filmCrawlingTextPlaceholder.backgroundColor = .black
        filmCrawlingTextPlaceholder.isUserInteractionEnabled = false
        filmCrawlingTextPlaceholder.addSubview(filmCrawlingText)
        filmCrawlingTextPlaceholder.addConstraints([
            filmCrawlingText.leadingAnchor.constraint(equalTo: filmCrawlingTextPlaceholder.leadingAnchor),
            filmCrawlingText.topAnchor.constraint(equalTo: filmCrawlingTextPlaceholder.topAnchor),
            filmCrawlingText.bottomAnchor.constraint(equalTo: filmCrawlingTextPlaceholder.bottomAnchor),
            filmCrawlingText.trailingAnchor.constraint(equalTo: filmCrawlingTextPlaceholder.trailingAnchor)])
        filmCrawlingTextPlaceholder.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filmCharacters.flashScrollIndicators()
        if !filmCrawlingText.isCrawling {
            filmCrawlingText.startCrawlingAnimation()
        }
    }
}

extension FilmDetailViewController: StarWarsTextViewDelegate {
    func starWarsTextViewDidStopCrawling(_ textView: StarWarsTextView, finished: Bool) {
        self.filmCrawlingText.scrollToTop()
        self.filmCrawlingText.startCrawlingAnimation()
    }
}
