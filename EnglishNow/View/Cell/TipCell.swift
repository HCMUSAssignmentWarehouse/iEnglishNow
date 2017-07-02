//
//  TipCell.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/3/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation

class TipCell: UITableViewCell {
    
    
    @IBOutlet weak var tipSegmented: UISegmentedControl!
    @IBOutlet weak var tipTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func tipSegmentedChanged(_ sender: AnyObject) {
        let index = tipSegmented.selectedSegmentIndex
        print("index: \(index)")
        switch index {
        case 0:
            Singleton.sharedInstance.partner.review?.gift.coke = Singleton.sharedInstance.partner.review.gift.coke + 1
        case 1:
            Singleton.sharedInstance.partner.review?.gift?.beer = Singleton.sharedInstance.partner.review.gift.beer + 1
        default:
            break
        }
    }
}
