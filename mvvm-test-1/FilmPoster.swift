//
//  FilmImage.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/02/09.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import Foundation
import UIKit

class FilmPoster: NSObject {
    var _filmTitle: String = ""
    var _filmPoster: UIImage = UIImage()
    
    /*init(filmTitle: String, filmPoster: UIImage) {
        self.filmTitle = filmTitle
        self.filmPoster = filmPoster
    }*/
    
    var filmTitle: String {
        get {
            return _filmTitle
        }
        set(newValue) {
            _filmTitle = newValue
        }
    }
    
    var filmPoster: UIImage {
        get {
            return _filmPoster
        }
        set(newValue) {
            _filmPoster = newValue
        }
    }
}
