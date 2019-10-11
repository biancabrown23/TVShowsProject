//
//  ShowsTableViewCell.swift
//  TVShows
//
//  Created by Bianca Brown on 10/4/19.
//  Copyright © 2019 Bee. All rights reserved.
//

import UIKit

class ShowsTableViewCell: UITableViewCell {
    @IBOutlet weak var showsImageView: UIImageView!
    
    @IBOutlet weak var showsNameLabel: UILabel!
    
    @IBOutlet weak var showsRatingLabel: UILabel!
    
    
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
