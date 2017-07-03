//
//  SpeakerRatingCell.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/3/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation
import Cosmos

class SpeakerRatingCell: UITableViewCell {
    
    @IBOutlet weak var totalRatingsLabel: UILabel!
    @IBOutlet weak var ratingControl: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingControl.settings.updateOnTouch = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
