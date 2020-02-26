//
//  FilmListViewModel.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/02/06.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import Foundation
import UIKit

class FilmListViewModel: NSObject {
    var films: [Film]!
    var filmPosters: [FilmPoster]!
    
    init(films: [Film], filmPosters: [FilmPoster]) {
        self.films = films
        self.filmPosters = filmPosters
    }
    
    func numberOfFilmsToDisplay(in section: Int) -> Int {
        return films.count
    }
    
    func filmToDisplay(for indexPath: IndexPath) -> Film {
        return films[indexPath.row]
    }
    
    func posterToDisplay(for indexPath: IndexPath) -> UIImage {
        let title = films[indexPath.row].title
        var index = -1
        
        for poster in filmPosters {
            if poster.filmTitle == title {
                index = filmPosters.firstIndex(of: poster)!
            }
        }
        
        return filmPosters[index].filmPoster
    }
}
