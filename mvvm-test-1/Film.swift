//
//  Films.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/02/03.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import Foundation

struct Film: Decodable {
    let title: String
    let release_date: String
    let director: String
    let producer: String
    let opening_crawl: String
    var characters: [String]? = []
    var posterURL: String?
    var rating: Double?
}
