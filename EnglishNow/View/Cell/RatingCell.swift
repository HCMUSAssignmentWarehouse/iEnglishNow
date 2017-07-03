//
//  RatingCell.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/3/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation
import Cosmos

class RatingCell: UITableViewCell {
    
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var ratingControl: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        ratingControl.settings.updateOnTouch = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
