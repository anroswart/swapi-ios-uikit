//
//  FilmListVC.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/01/30.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import UIKit

// Safe segue handling
fileprivate enum VCSegue: String {
    case showFilmDetail
}

enum ReusableCellId: String {
    case filmCell
}

class FilmListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewFilms: UITableView!
    
    var viewModel: FilmListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewFilms.delegate = self
        tableViewFilms.dataSource = self
    }
    
    /// MARK - FilmList UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Initialize from splash load
        return viewModel!.numberOfFilmsToDisplay(in: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableViewFilms.dequeueReusableCell(withIdentifier: ReusableCellId.filmCell.rawValue, for: indexPath) as? FilmCell {
            cell.configCell(film: viewModel!.filmToDisplay(for: indexPath), poster: viewModel!.posterToDisplay(for: indexPath))
            return cell
        } else {
            return FilmCell()
        }
    }
    
    /// Mark -  Transition to next VC
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: VCSegue.showFilmDetail.rawValue, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FilmDetailVC {
            let indexPath = sender as! IndexPath
            destination.viewModel = FilmDetailViewModel(film: self.viewModel!.films[indexPath.row])
        }
    }
}


