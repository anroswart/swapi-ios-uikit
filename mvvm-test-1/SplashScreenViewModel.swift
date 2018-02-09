//
//  SplashScreenViewModel.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/02/07.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import Foundation

class SplashScreenViewModel: NSObject {
    
    // Lazy - initialize as soon as its needed
    lazy var swapiService: SWAPIService = {
        return SWAPIService()
    }()
    
    // This will hold film data
    var films = [Film]()
    var filmPosters = [FilmPoster]()
    
    func getFilms(completion: @escaping () -> Void) {
        swapiService.fetchFilms { success, reFilms in
            DispatchQueue.main.async {
                if success {
                    print ("Films Returned")
                    self.films = reFilms
                    print(self.films.count)
                    
                    let groupChars = DispatchGroup()
                    let serialQueue = DispatchQueue(label: "serialQueue")
                    
                    for index in 0..<self.films.count {
                        groupChars.enter()
                        self.getFilmCharacters(forFilm: self.films[index]) { filmWC in
                            serialQueue.async {
                                self.films[index].characters = filmWC.characters!
                                print(self.films[index].characters!)
                                groupChars.leave()
                            }
                        }
                    }
                    
                    groupChars.notify(queue: .main) {
                        // Sort films and assign to view model
                        self.films = self.films.sorted { (lhs, rhs) in return lhs.release_date < rhs.release_date }
                        // Get Film Posters
                        let groupPosters = DispatchGroup()
                        
                        for index in 0..<self.films.count {
                            groupPosters.enter()
                            self.getFilmPoster(forFilm: self.films[index]) { filmPoster, film in
                                serialQueue.async {
                                    self.filmPosters.append(filmPoster)
                                    self.films[index].rating = film.rating
                                    groupPosters.leave()
                                }
                            }
                        }
                        
                        groupPosters.notify(queue: .main) {
                            
                            completion()
                        }
                    }
                } else {
                    print("Unable to retieve films API Error")
                }
            }
        }
    }
    
    func getFilmPoster(forFilm: Film, completion: @escaping(_ filmPoster: FilmPoster, _ film: Film) -> Void) {
        let filmPoster = FilmPoster()
        var film: Film = forFilm
        
        swapiService.getPosters(forTitle: forFilm.title) { success, image, rating in
            DispatchQueue.main.async {
                if success {
                    filmPoster.filmTitle = forFilm.title
                    filmPoster.filmPoster = image
                    film.rating = rating
                } else {
                    print("Unable to retrieve posters")
                }
                completion(filmPoster, film)
            }
        }
    }
    
    func getFilmCharacters(forFilm: Film, completion: @escaping(_ film: Film) -> Void) {
        var film: Film = forFilm
        
        swapiService.fetchCharacters(charURLs: forFilm.characters!) { success, filmChars in
            DispatchQueue.main.async {
                if success {
                    film.characters! = filmChars
                } else {
                    print("Unable to retrieve films API Error")
                }
                completion(film)
            }
        }
    }
    
    func numberOfFilmsToDisplay(in section: Int) -> Int {
        return films.count
    }
}
