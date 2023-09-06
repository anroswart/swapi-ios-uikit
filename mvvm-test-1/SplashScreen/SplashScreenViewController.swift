import UIKit

fileprivate enum Segues: String {
    case showFilmList
}

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var splashLogoImageView: UIImageView!
    
    private let filmService = FilmService()
    
    // Animation state handling
    private var networkingComplete = false
    private var rotateAnimationComplete = false
    private var scaleAnimationComplete = false
    
    private var networkingCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFilmData()
    }
    
    private func getFilmData() {
        networkingComplete = false
        configureLogoAnimation()
        filmService.fetchFilms { error in
            self.networkingComplete = true
            self.configureNetworkingCompletion(withError: error)
            if (self.scaleAnimationComplete && self.rotateAnimationComplete) {
                self.networkingCompletion?()
            }
        }
    }
    
    private func configureNetworkingCompletion(withError error: Error?) {
        self.networkingCompletion = {
            if error == nil {
                self.showFilms()
            } else {
                self.showAlert(forError: error) {
                    self.getFilmData()
                }
            }
        }
    }
    
    private func configureLogoAnimation() {
        self.scaleAnimationComplete = false
        self.rotateAnimationComplete = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.startLogoAnimation()
        }
    }
    
    // Mark - Splash logo animations
    private func startLogoAnimation() {
        containerView.scaleAnimation(duration: 3, completion: {
            self.scaleAnimationComplete = true
            // Check if film data is done loading
            if (self.networkingComplete && self.rotateAnimationComplete) {
                self.networkingCompletion?()
            } else if self.rotateAnimationComplete {
                self.scaleAnimationComplete = false
                self.startLogoAnimation()
            }
        })
        splashLogoImageView.rotateAnimation(duration: 3, completion: {
            self.rotateAnimationComplete = true
            // Check if film data is done loading
            if (self.networkingComplete && self.scaleAnimationComplete) {
                self.networkingCompletion?()
            } else if self.scaleAnimationComplete {
                self.rotateAnimationComplete = false
                self.startLogoAnimation()
            }
        })
    }
    
    private func showAlert(forError error: Error?, withTryAgainAction tryAgainAction: @escaping() -> Void) {
        let alert = UIAlertController(title: "Something went wrong", message: error?.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in
            alert.dismiss(animated: true) {
                tryAgainAction()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // Mark - Transition
    private func showFilms() {
        self.performSegue(withIdentifier: Segues.showFilmList.rawValue, sender: nil)
    }
    
    // Inject FilmListViewController dependencies
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = (segue.destination as? UINavigationController)?.topViewController as? FilmListViewController {
            destination.viewModel = FilmListViewModel(films: filmService.films)
            stopAnimations()
        }
    }
    
    private func stopAnimations() {
        self.containerView.layer.removeAllAnimations()
        self.splashLogoImageView.layer.removeAllAnimations()
    }
}
