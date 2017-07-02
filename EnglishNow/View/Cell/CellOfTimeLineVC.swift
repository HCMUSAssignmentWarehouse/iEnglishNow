//
//  CellOfTimeLineVC.swift
//  EnglishNow
//
//  Created by Nha T.Tran on 5/21/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CellOfTimeLineVC: UITableViewCell {
    
    let avatar: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named:"sample.jpg")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.layer.cornerRadius = 16
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()

    
    let photo: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named:"sample.jpg")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.layer.cornerRadius = 16
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()

    let btnLike: UIButton = {
    
        let btn = UIButton()
        btn.imageView?.image = UIImage(named: "like.png")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    
    let txtName: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let txtTime: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Arial" , size: 16)

        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    let txtNumberOfLike: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont(name: "Arial" , size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let txtContent: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "Arial" , size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()


    var photoBigHeightAnchor: NSLayoutConstraint?
    var photoSmallHeightAnchor: NSLayoutConstraint?
    
    var status: Status?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initShow()
        // Initialization code
    }

    func initShow(){
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 10
        
        
        self.addSubview(avatar)
        self.addSubview(txtName)
        self.addSubview(txtTime)
        self.addSubview(btnLike)
        self.addSubview(txtNumberOfLike)
        self.addSubview(txtContent)
        self.addSubview(photo)
        
        avatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 56).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        txtName.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        txtName.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 8).isActive = true
        txtName.heightAnchor.constraint(equalToConstant: 24).isActive = true
        txtName.rightAnchor.constraint(equalTo: txtNumberOfLike.leftAnchor, constant: -8).isActive = true
        
        txtTime.topAnchor.constraint(equalTo: txtName.bottomAnchor, constant: 8).isActive = true
        txtTime.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 8).isActive = true
        txtTime.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        txtTime.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        txtContent.topAnchor.constraint(equalTo: txtTime.bottomAnchor, constant: 8).isActive = true
        txtContent.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 72).isActive = true
        txtContent.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        
        photoBigHeightAnchor = photo.heightAnchor.constraint(equalToConstant: 100)
        photoSmallHeightAnchor = photo.heightAnchor.constraint(equalToConstant: 1)
        
        photo.topAnchor.constraint(equalTo: txtContent.bottomAnchor, constant: 8).isActive = true
        photo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 72).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 150).isActive = true
        photo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        btnLike.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        btnLike.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive =  true
        btnLike.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btnLike.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        txtNumberOfLike.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        txtNumberOfLike.rightAnchor.constraint(equalTo: btnLike.leftAnchor, constant: -4).isActive = true
        txtNumberOfLike.widthAnchor.constraint(equalToConstant: 76).isActive = true
        txtNumberOfLike.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        onClickBtnLike()
    }
    
    func onClickBtnLike (){
        btnLike.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    func onClick(btn: UIButton) {
        
        
        if (status?.isUserLiked == false){
            
            if let user = Auth.auth().currentUser{
                Database.database().reference().child("status").child((status?.statusId)!).child("like").child(user.uid).setValue(true)
                
                var likeNumber = (status?.likeNumber)! + 1
                Database.database().reference().child("status").child((status?.statusId)!).child("like_number").setValue(likeNumber)
                
                txtNumberOfLike.text = "\(likeNumber)"
                
                print("status?.user: \(status?.user)")
                print("status?.statusId: \(status?.statusId)")
                print("user.uid: \(user.uid)")
                Database.database().reference().child("user_profile").child((status?.user)!).child("status").child((status?.statusId)!).child("like").child(user.uid).setValue(true)
                Database.database().reference().child("user_profile").child((status?.user)!).child("status").child((status?.statusId)!).child("like_number").setValue(likeNumber)
                status?.isUserLiked = true
                status?.likeNumber = likeNumber
                
                btnLike.setBackgroundImage(UIImage(named: "liked.png"), for: UIControlState.normal)
            }
            
            
        }
        else {
            
            if let user = Auth.auth().currentUser{
                Database.database().reference().child("status").child((status?.statusId)!).child("like").child(user.uid).setValue(false)
                
                var likeNumber = (status?.likeNumber)! - 1
                
                Database.database().reference().child("status").child((status?.statusId)!).child("like_number").setValue(likeNumber)
                
                txtNumberOfLike.text = "\(likeNumber)"
                
                
                Database.database().reference().child("user_profile").child((status?.user)!).child("status").child((status?.statusId)!).child("like").child(user.uid).setValue(false)
                Database.database().reference().child("user_profile").child((status?.user)!).child("status").child((status?.statusId)!).child("like_number").setValue(likeNumber)
                
                
                status?.isUserLiked = false
                status?.likeNumber = likeNumber
                
                
                btnLike.setBackgroundImage(UIImage(named: "like.png"), for: UIControlState.normal)
            }
            
            
        }
        
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
