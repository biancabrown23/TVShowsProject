//
//  TV Shows ViewController.swift
//  TVShows
//
//  Created by Bianca Brown on 10/4/19.
//  Copyright © 2019 Bee. All rights reserved.
//

import UIKit

class TVShowsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var showsTableView: UITableView!
    @IBOutlet weak var showsSearchBar: UISearchBar!
    
    var showListings = [ShowInfo]() {
        didSet {
            showsTableView.reloadData()
        }
    }
    
    var keyword: String? {
        didSet {
            showsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsSearchBar.delegate = self
        showsTableView.delegate = self
        showsTableView.dataSource = self
        // loadShowData(keyword: showsSearchBar.text!)
    }
    
    private func loadShowData(keyword: String) {
        APIClientManager.shared.getElements(keyword: keyword) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let success):
                    self.showListings = success
                    dump(self.showListings)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return showListings.count
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 220
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = showsTableView.dequeueReusableCell(withIdentifier: "showsCell", for: indexPath) as? ShowsTableViewCell else {
                return UITableViewCell()
            }
            let show = showListings[indexPath.row]
            cell.showsRatingLabel.text = show.show.rating?.average?.description ?? "N/A"
            cell.showsNameLabel.text = show.show.name
            
            ImageFullManager.manager.getFullImage(from: show.show.image?.medium ?? "g") { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        cell.imageView?.image = image
                        self.showsTableView.reloadData()
                    }
                }
            }
            
            return cell
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let episodeVCDestination = segue.destination as? TVEpisodesViewController
            let infoFromTableViewRow = showsTableView.indexPathForSelectedRow!.row
            
            let show = showListings[infoFromTableViewRow]
            episodeVCDestination?.previousShowData = show
            
//            episodeVCDestination?.InfoFromShowData = showListings[infoFromTableViewIndex!]
            
        }
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let episode = storyboard.instantiateViewController(identifier: "TVEpisodesID")
        
//        let infoForEpisodeVC = showListings
        
//        episodeVC?.episodeListings =
        
//        identifier for the storyboard - Storyboard ID
        
        
//        ViewController we want to go to. We need to go from the Shows View Controller to the Episode View Controller.
        
        
        
//        guard segue.destination is TVEpisodesViewController else {
//            fatalError("This is not an episode that we have.")
//            guard showsTableView.indexPathForSelectedRow != nil else {
//                fatalError()}
//            }
        }
    
    

    extension TVShowsViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            keyword = searchText
            loadShowData(keyword: keyword ?? "g")
                }
            }

