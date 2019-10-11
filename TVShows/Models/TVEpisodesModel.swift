//
//  TVEpisodesModel.swift
//  TVShows
//
//  Created by Bianca Brown on 10/4/19.
//  Copyright © 2019 Bee. All rights reserved.
//

import Foundation

struct EpisodeWrapper: Codable {
    let name: String?
    let season: Int
    let number: Int
    let image: imgWrapper?
    let summary: String?
}

struct imgWrapper: Codable {
    let medium: String
}
