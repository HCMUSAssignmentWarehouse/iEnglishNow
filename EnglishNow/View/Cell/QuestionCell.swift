//
//  QuestionCell.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/3/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation
import Cosmos

class QuestionCell: UITableViewCell {
    
    
    @IBOutlet weak var ratingControl: CosmosView!
    @IBOutlet weak var questionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        ratingControl.rating = 0
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        ratingControl.didFinishTouchingCosmos = valueChanged
        
        // Configure the view for the selected state
    }
    
    func valueChanged(_ value:Double){
        if Singleton.sharedInstance.partner.type == UserType.speaker{
            Singleton.sharedInstance.partner.review?.rating = value
        }
        else{
            let skill = questionLabel.text
            if skill == "Listening"{
                Singleton.sharedInstance.partner.review?.ratings?.listening = value
            }
            else if skill == "Pronounciation"{
                Singleton.sharedInstance.partner.review?.ratings?.pronounciation = value
            }
            else if skill == "Fluency"{
                Singleton.sharedInstance.partner.review?.ratings?.fluency = value
            }
            else{
                Singleton.sharedInstance.partner.review?.ratings?.vocabulary = value
            }
        }
    }
    
}
