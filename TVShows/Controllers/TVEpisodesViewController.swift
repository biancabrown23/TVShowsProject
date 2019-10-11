//
//  TVEpisodesViewController.swift
//  TVShows
//
//  Created by Bianca Brown on 10/4/19.
//  Copyright © 2019 Bee. All rights reserved.
//

import UIKit

class TVEpisodesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    var previousShowData: ShowInfo!
    
    
    
    var episodeListings = [EpisodeWrapper](){
        didSet {
            episodesTableView.reloadData()
        }
    }
    
//    var InfoFromShowData: ShowInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        getShowData(showID: previousShowData.show.id)
//        print("\(InfoFromShowData.show.id)")
    }
    
    func getShowData(showID:Int) {
        APIClientManager.shared.getEpisdoes(showid: previousShowData.show.id) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                self.episodeListings = data.self
                dump(self.episodeListings)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedIndexPath =
            episodesTableView.indexPathForSelectedRow,
            let episodeSummary = segue.destination as? DetailedEpisodesViewController else {return}
        let selectedPath = episodeListings[selectedIndexPath.row]
        episodeSummary.episodes = selectedPath
        
//            let  episodedescVCDestination = seque.destination as? DetailedEpisodesViewController
//            let summaryDecs = episodesTableView.indexPathForSelectedRow!.row
//            let ep = episodeListings[summaryDecs]
//            episodedescVCDestination.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeListings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                                                                //Custom UITableViewCell()
        guard let cell = episodesTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodesTableViewCell else {
            return UITableViewCell()
        }
        let imageLinkOfTheShows = episodeListings[indexPath.row].image
        
        let summaryLabel = episodeListings[indexPath.row]
        
        cell.episodeNameLabel.text = previousShowData.show.name
        cell.episodeSeasonNumberLabel.text = "Season \(summaryLabel.season), Episode: \(summaryLabel.number)"
        
        
        ImageFullManager.manager.getFullImage(from: imageLinkOfTheShows?.medium ?? "") { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                cell.episodeImageLabel.image = image
                
            }
        }
        return cell
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }
    
}
