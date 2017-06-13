//
//  CellOfTimeLineVC.swift
//  Speak now
//
//  Created by Nha T.Tran on 5/21/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit

class CellOfTimeLineVC: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var txtContent: UILabel!
    @IBOutlet weak var txtNumberOfLike: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBAction func actionLike(_ sender: Any) {
        if (numberClick == 1){
            
            btnLike.setBackgroundImage(UIImage(named: "liked.png"), for: UIControlState.normal)
            numberClick = 0
        }
        else if (numberClick == 0){
            btnLike.setBackgroundImage(UIImage(named: "like.png"), for: UIControlState.normal)
            numberClick = 1
        }
        
    }
    var numberClick = 1
    override func awakeFromNib() {
        super.awakeFromNib()
        initShow()
        // Initialization code
    }

    func initShow(){
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 10
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
