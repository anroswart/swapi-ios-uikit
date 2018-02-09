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
                // Completion code
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
                    for Film in SWAPIReturn.results {
                        //Fetch Characters for Film
                        //print("\(Film.title)")
                        
                        films.append(Film)
                        //print(Film.title)
                    }
                    complete(true, films)
                } catch let jsonErr {
                    print("Could not decode JSON:", jsonErr)
                    complete(false, films)
                }
                
                /*if let response = response {
                    print(response)
                }*/
            })
            task.resume()
        }
    }
    
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
                    //complete(false, films, nil)
                    return
                }
                
                guard let data = data else {
                    print("No data returned")
                    //complete(false, films, nil)
                    return
                }
                
                //let dataString = String(data: data, encoding: .utf8)
                //print(dataString!)
                
                do {
                    let SWAPIReturn = try
                        JSONDecoder().decode(SwapiCharReturn.self, from: data)
                    serialQueue.async {
                        filmCharNames.append(SWAPIReturn.name)
                        //print(SWAPIReturn.name)
                        group.leave()
                    }
                } catch let jsonErr {
                    print("Could not decode JSON:", jsonErr)
                    complete(false, filmCharNames)
                }
                
                /*if let response = response {
                 print(response)
                 }*/
            })
            task.resume()
        }
        
        group.notify(queue: .main) {
            complete(true, filmCharNames)
        }
    }
    
    func fetchCharactersOld(charURLs: [String], complete: @escaping(_ success: Bool, _ filmChars: [String])->()) {
    
        var filmCharNames = [String]()
        DispatchQueue.global().sync {
            for url in charURLs {
                var request = URLRequest(url: URL(string: url)!)
                request.httpMethod = "GET"
                let session =  URLSession.shared
                let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                    // Check for error
                    guard error == nil else {
                        print("Data Task Error")
                        //complete(false, films, nil)
                        return
                    }
                    
                    guard let data = data else {
                        print("No data returned")
                        //complete(false, films, nil)
                        return
                    }
                    
                    //let dataString = String(data: data, encoding: .utf8)
                    //print(dataString!)
                    
                    do {
                        let SWAPIReturn = try
                            JSONDecoder().decode(SwapiCharReturn.self, from: data)
                        print(SWAPIReturn.name)
                        filmCharNames.append(SWAPIReturn.name)
                        
                    } catch let jsonErr {
                        print("Could not decode JSON:", jsonErr)
                        complete(false, filmCharNames)
                    }
                    
                    /*if let response = response {
                     print(response)
                     }*/
                })
                task.resume()
            }
            complete(true, filmCharNames)
        }
    }
}
