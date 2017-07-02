//
//  CommentCell.swift
//  EnglishNow
//
//  Created by IceTeaViet on 6/19/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    let avatar: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named:"sample.jpg")
        imageview.frame = CGRect(x: 4, y: 4, width: 36, height: 36)
        //imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()

    let txtUserName: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let txtComment: UILabel = {
        let label = UILabel()
        label.text = "comment"
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Arial" , size: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initShow()
        // Initialization code
    }
    
    func initShow(){
        
        self.addSubview(avatar)
        self.addSubview(txtUserName)
        self.addSubview(txtComment)
      
        /*avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        avatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 32).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        txtUserName.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        txtUserName.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 8).isActive = true
        txtUserName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        txtUserName.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        txtComment.topAnchor.constraint(equalTo: txtUserName.bottomAnchor, constant: 4).isActive = true
        txtComment.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 8).isActive = true
        txtComment.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        txtComment.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true*/
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
