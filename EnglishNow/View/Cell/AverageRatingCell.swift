//
//  AverageRatingCell.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/3/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation

class AverageRatingCell: UITableViewCell {
    
    @IBOutlet weak var totalRatingsLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var circlePoint: UIView!
    @IBOutlet weak var circlePoint1: UIView!
    
    var review:Review?{
        didSet{
            let point = ((review?.ratings?.listening)! + (review?.ratings?.listening)! + (review?.ratings?.fluency)! + (review?.ratings?.vocabulary)!)/4
            let roundedPoint = round(point * 10) / 10
            pointsLabel.text = "\(roundedPoint)"
            //totalRatingsLabel.text = review
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        circlePoint.clipsToBounds = true
        circlePoint.layer.cornerRadius = 12
        circlePoint1.clipsToBounds = true
        circlePoint1.layer.cornerRadius = 9
        // Configure the view for the selected state
    }
    
}
