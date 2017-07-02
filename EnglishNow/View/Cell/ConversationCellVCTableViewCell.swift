//
//  ConversationCellVCTableViewCell.swift
//  EnglishNow
//
//  Created by IceTeaViet on 5/21/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import UIKit

class ConversationCellVCTableViewCell: UITableViewCell {
    
    @IBOutlet var starButton: [UIButton]!
    
    @IBAction func starbuttonTapped(_ sender: UIButton) {
        
        let tag = sender.tag
        
        for button in starButton{
            if (button.tag <= tag){
                //selected
                button.setTitleColor(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), for: .normal)
            }else{
                //not selected
                button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            }
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
