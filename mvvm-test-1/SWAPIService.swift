//
//  SWAPIService.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/01/30.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import Foundation

struct SwapiFilmReturn: Decodable {
    let count: Int
    let results: [Film]
}

struct SwapiCharReturn: Decodable {
    let name: String
}

class SWAPIService: NSObject {
    
    private let baseURL = "https://swapi.co/api/"
    
    func fetchFilms(complete: @escaping(_ success: Bool, _ films: [Film])->() ) {
        DispatchQueue.global().async {
            let functionUrl: String = "\(self.baseURL)films/"
            var request = URLRequest(url: URL(string: functionUrl)!)
            request.httpMethod = "GET"
            let session =  URLSession.shared
            
            var films = [Film]()
            
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
                //print(dataString!)
                
                do {
                    let SWAPIReturn = try
                        JSONDecoder().decode(SwapiFilmReturn.self, from: data)
                    
                    for film in SWAPIReturn.results {
                        films.append(film)
                    }
                    complete(true, films)
                } catch let jsonErr {
                    print("Could not decode JSON:", jsonErr)
                    complete(false, films)
                }
            })
            task.resume()
        }
    }
    
    //Using Grand Central Dispatch for array of Character URLs
    func fetchCharacters(charURLs: [String], complete: @escaping(_ success: Bool, _ filmChars: [String])->()) {
        var filmCharNames = [String]()
        let group = DispatchGroup()
        let serialQueue = DispatchQueue(label: "serialQueue")
        
        for url in charURLs {
            group.enter()
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            let session =  URLSession.shared
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
                //print(dataString!)
                
                do {
                    let SWAPIReturn = try
                        JSONDecoder().decode(SwapiCharReturn.self, from: data)
                    
                    serialQueue.async {
                        filmCharNames.append(SWAPIReturn.name)
                        group.leave()
                    }
                } catch let jsonErr {
                    print("Could not decode JSON:", jsonErr)
                    complete(false, filmCharNames)
                }
            })
            task.resume()
        }
        
        group.notify(queue: .main) {
            complete(true, filmCharNames)
        }
    }
}
