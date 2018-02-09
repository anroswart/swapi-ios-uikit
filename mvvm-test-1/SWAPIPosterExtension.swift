//
//  TMDBService.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/02/03.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import Foundation
import UIKit

struct ReturnFilm: Decodable{
    let title: String
    let poster_path: String
    let vote_average: Double
}

struct TMDBReturn: Decodable {
    let results: [ReturnFilm]
}

extension SWAPIService {
    // Search for specific film to capture poster and rating
    func searchFilms(title: String, complete: @escaping(_ success: Bool, _ imgUrl: String, _ rading: Double) -> Void) {
        DispatchQueue.global().async {
            let formatTitle = title.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            let functionUrl: String = "https://api.themoviedb.org/3/search/movie?include_adult=false&query=\(formatTitle!)&language=en-US&api_key=026ed4b253a6531903d424d2f2008911"
            var request = URLRequest(url: URL(string: functionUrl)!)
            request.httpMethod = "GET"
            let session =  URLSession.shared
            
            var imgUrl = ""
            var rating = 0.0
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                // Check for error
                guard error == nil else {
                    print("Data Task Error")
                    return
                }
                
                guard let data = data else {
                    print("No data returned")
                    return
                }
                
                //let dataString = String(data: data, encoding: .utf8)
                //print("\n\(dataString!)")
                
                do {
                    let SWAPIReturn = try
                        JSONDecoder().decode(TMDBReturn.self, from: data)
                    
                    imgUrl = SWAPIReturn.results[0].poster_path
                    rating = SWAPIReturn.results[0].vote_average
                    
                    if (!imgUrl.isEmpty) {
                        complete(true, imgUrl, rating)
                    }
                } catch let jsonErr {
                    print("Could not decode JSON:", jsonErr)
                    complete(false, imgUrl, rating)
                }
            })
            task.resume()
        }
    }
    
    // Get poster from search results
    func getPosters(forTitle: String, complete: @escaping(_ success: Bool, _ image: UIImage, _ rating: Double) -> Void) {
        self.searchFilms(title: forTitle) { success, url, rating in
            if url.isEmpty {
                complete(true, UIImage(named: "background")!, rating)
                return
            }
            
            let functionUrl: String = "https://image.tmdb.org/t/p/w500\(url)"
            let url = URL(string: functionUrl)
            
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                DispatchQueue.main.async {
                    complete(true, UIImage(data: data!)!, rating)
                }
            }).resume()
        }
    }
}
