//
//  ContactTableViewCell.swift
//  EnglishNow
//
//  Created by IceTeaViet on 6/12/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    
    @IBOutlet var avatar: UIImageView!
    
    @IBOutlet var txtName: UILabel!
    
    @IBOutlet var txtContent: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initShow()
    }

    func initShow(){
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 28
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
