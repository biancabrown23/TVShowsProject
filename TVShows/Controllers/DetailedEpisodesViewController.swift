//
//  DetailedEpisodesViewController.swift
//  TVShows
//
//  Created by Bianca Brown on 10/4/19.
//  Copyright © 2019 Bee. All rights reserved.
//

import UIKit

class DetailedEpisodesViewController: UIViewController {
    
    @IBOutlet weak var episodeImageLabel: UIImageView!
    
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeSeasonNumber: UILabel!
    @IBOutlet weak var episodeDetailedSummary: UITextView!
    
    var episodes: EpisodeWrapper!
    
    private func loadepisodes() {
        guard let episodeDetails = episodes else {return}
        if let unwrappedURLString = episodeDetails.image?.medium {
            let imageURL = URL(string: unwrappedURLString)
            do {
                let image = try Data.init(contentsOf: imageURL!)
                episodeImageLabel.image = UIImage.init(data: image)
            } catch {
                print(error)
        }
    }
        episodeNameLabel.text = "Episode Title: \(episodeDetails.name!)"
        episodeNumberLabel.text = "Episode Number: \(episodeDetails.number)"
        episodeSeasonNumber.text = "Season Number: \(episodeDetails.season)"
        episodeDetailedSummary.text = episodeDetails.summary?.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadepisodes()
    }
    

}

