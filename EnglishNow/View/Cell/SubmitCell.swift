//
//  SubmitCell.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/3/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation

class SubmitCell: UITableViewCell {
    
    @IBOutlet weak var submitButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        setRoundedButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setRoundedButton(){
        submitButton.clipsToBounds = true
        submitButton.layer.cornerRadius = 6
    }
    @IBAction func onSubmitTouchDown(_ sender: AnyObject) {
    }
}
