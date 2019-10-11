//
//  APIClientManager.swift
//  TVShows
//
//  Created by Bianca Brown on 10/4/19.
//  Copyright © 2019 Bee. All rights reserved.
//

import Foundation

class APIClientManager {
    private init() {}
    
    static let shared = APIClientManager()
    // this is a singleton pattern of the ElementAPIManager
    
    
    func getElements(keyword: String, completionHandler: @escaping (Result<[ShowInfo],AppError>) -> ()) {
        
        let urlString = "http://api.tvmaze.com/search/shows?q=\(keyword)"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL));
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) {(result) in
          switch result {
          case .failure(let error):
            completionHandler(.failure(error))
          case .success(let data):
            do {
              let showInfo = try JSONDecoder().decode([ShowInfo].self, from: data)
                completionHandler(.success(showInfo))
            } catch {
              completionHandler(.failure(.couldNotParseJSON(rawError: error)))
            }
          }
        }
      }
    
    func getEpisdoes(showid: Int, completionHandler: @escaping (Result<[EpisodeWrapper],AppError>) -> ()) {
        
       let urlString = "http://api.tvmaze.com/shows/\(showid)/episodes"
        
        // let urlString = "http://api.tvmaze.com/shows/1/episodes"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.noDataReceived));
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let episodeInfo = try JSONDecoder().decode([EpisodeWrapper].self, from: data); completionHandler(.success(episodeInfo)) }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    

}


//    NetworkHelper.manager.performDataTask(withUrl: url, andHTTPBody: encodedData, andMethod: .post) { (result) in
//            switch result {
//            case .failure(let error):
//                completionHandler(.failure(.other(rawError: error)))
//            case .success(let success):
//                completionHandler(.success(success))
//            }
//        }
//
//
////            .performDataTask(withUrl: urlString, andHTTPBody: encodedData, andMethod: .post) { (result) in
////            switch result {
////            case .failure(let error):
////                completionHandler(.failure())
////            }
//
//        }
//        }
//
