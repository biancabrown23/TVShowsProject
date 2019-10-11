//
//  ImageHelper.swift
//  TVShows
//
//  Created by Bianca Brown on 10/4/19.
//  Copyright © 2019 Bee. All rights reserved.
//

import Foundation
import UIKit

class ImageFullManager {
  static let manager = ImageFullManager()
  
   func getFullImage(from urlString: String,
                       completionHandler: @escaping (Result<UIImage, AppError>) -> ()) {

    guard let url = URL(string: urlString) else {completionHandler(.failure(.badURL))
      return
    }
    
    NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
      switch result {
      case let .failure(error):
        completionHandler(.failure(error))
      case let .success(data):
        guard let onlineImage = UIImage(data: data) else {
          completionHandler(.failure(.notAnImage))
          return
        }
        completionHandler(.success(onlineImage))
      }
    }
  }
  
  private init() {}
}
