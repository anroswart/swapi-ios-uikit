//
//  FilmCell.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/02/08.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import UIKit

class FilmCell: UITableViewCell {
    
    @IBOutlet weak var filmPoster: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmReleaseDate: UILabel!
    @IBOutlet weak var filmDirectors: UILabel!
    @IBOutlet weak var filmProducers: UILabel!
    
    func configCell(film: Film, poster: UIImage) {
        filmPoster.image = poster
        filmTitle.text = film.title
        filmReleaseDate.text = film.release_date
        filmDirectors.text = film.director
        filmProducers.text = film.producer
    }
}
