//
//  SplashScreenVC.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/01/30.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import UIKit

// Safe segue handling
fileprivate enum VCSegue: String {
    case showFilmList
}

class SplashScreenVC: UIViewController {

    @IBOutlet weak var viewSplashContainer: UIView!
    @IBOutlet weak var imgViewSplashLogo: UIImageView!
    
    fileprivate let viewModel = SplashScreenViewModel()
    
    // Minor state handling
    fileprivate var dataDone = false
    fileprivate var animRotateDone = false
    fileprivate var animScaleDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        viewModel.getFilms {
            // Executes when done fetching films
            print("Films Complete")
            self.dataDone = true
            if (self.animScaleDone && self.animRotateDone) {
                self.showFilms()
            }
            
        }
    }
    
    fileprivate func initView() {
        // Delay animating the spash, personal preference
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.startAnimating()
            print("Started Animating")
        }
    }
    
    /// Mark - Splash logo animations
    
    // Stop the fired animations
    fileprivate func stopAnimations() {
        self.viewSplashContainer.layer.removeAllAnimations()
        self.imgViewSplashLogo.layer.removeAllAnimations()
    }

    // Fire the animations
    fileprivate func startAnimating() {
        viewSplashContainer.scaleAnimation(duration: 9, complete: {
            print("Scale Done")
            self.animScaleDone = true
            // Check if film data is done loading, if - launch
            if (self.dataDone && self.animRotateDone) {
                self.showFilms()
            } else {
                //continue animation
                
            }
        })
        imgViewSplashLogo.rotateAnimation(duration: 9, complete: {
            print("Rotation Done")
            self.animRotateDone = true
            // Check if film data is done loading, if - launch
            if (self.dataDone && self.animScaleDone) {
                self.showFilms()
            } else {
                //continue animation
            }
        })
    }
    
    /// Mark -  Transition to next VC
    
    // Segue to FilmListVC
    fileprivate func showFilms() {
        self.performSegue(withIdentifier: VCSegue.showFilmList.rawValue, sender: nil)
    }
    
    // Handle transition to new VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FilmListVC {
            // Setup FilmListVC
            destination.viewModel = FilmListViewModel(films: self.viewModel.films, filmPosters: self.viewModel.filmPosters)
            // Stop animations
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.stopAnimations()
            }
        }
    }
}

