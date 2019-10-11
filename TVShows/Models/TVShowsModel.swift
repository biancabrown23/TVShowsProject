//
//  TVShowsModel.swift
//  TVShows
//
//  Created by Bianca Brown on 10/4/19.
//  Copyright © 2019 Bee. All rights reserved.
//

import Foundation

struct ShowInfo: Codable {
    let show: ShowWrapper
}

struct ShowWrapper: Codable {
    let rating: ratingWrapper?
    let name: String
    let image: imageWrapper?
    let id: Int
}

struct ratingWrapper: Codable {
    let average: Double?
}

struct imageWrapper: Codable {
    let medium: String
}


