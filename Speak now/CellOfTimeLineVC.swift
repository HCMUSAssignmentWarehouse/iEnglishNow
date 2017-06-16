//
//  CellOfTimeLineVC.swift
//  Speak now
//
//  Created by Nha T.Tran on 5/21/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CellOfTimeLineVC: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var txtContent: UILabel!
    @IBOutlet weak var txtNumberOfLike: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    var status: Status?
    
    @IBAction func actionLike(_ sender: Any) {
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
