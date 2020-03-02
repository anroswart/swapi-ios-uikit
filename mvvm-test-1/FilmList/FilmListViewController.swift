import UIKit

fileprivate enum Segues: String {
    case showFilmDetail
}

fileprivate enum ReusableCellId: String {
    case filmCell
}

class FilmListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableViewFilms: UITableView!
    
    var viewModel: FilmListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewFilms.delegate = self
        tableViewFilms.dataSource = self
        title = "Star Wars Films"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfFilmsToDisplay(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if
            let cell = tableViewFilms.dequeueReusableCell(withIdentifier: ReusableCellId.filmCell.rawValue, for: indexPath) as? FilmCell,
            let film = viewModel?.filmToDisplay(at: indexPath) {
            cell.configureCell(with: film)
            return cell
        } else {
            fatalError("Unable to configure FillCell")
        }
    }
    
    // Mark - Transition
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Segues.showFilmDetail.rawValue, sender: indexPath)
    }
    
    // Configure FilmDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let destination = (segue.destination as? UINavigationController)?.topViewController as? FilmDetailViewController,
            let indexPath = sender as? IndexPath,
            let film = viewModel?.films[indexPath.row] {
            destination.viewModel = FilmDetailViewModel(withFilm: film)
        }
    }
}


