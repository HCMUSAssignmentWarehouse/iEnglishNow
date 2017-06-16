//
//  ContactTableViewCell.swift
//  Speak now
//
//  Created by Nha T.Tran on 6/12/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
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
        avatar.layer.cornerRadius = 34
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
