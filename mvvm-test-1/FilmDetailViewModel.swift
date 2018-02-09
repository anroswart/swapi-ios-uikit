//
//  FilmDetailViewModel.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/02/07.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import Foundation

class FilmDetailViewModel: NSObject {
    var film: Film!
    
    init(film: Film) {
        self.film = film
    }
    
    func getOpeningCrawl() -> String {
        let newLines = "\n\n\n\n\n\n\n\n\n\n\n\n"
        return "\(newLines)\(film.opening_crawl)\(newLines)"
    }
}
