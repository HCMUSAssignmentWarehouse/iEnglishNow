//
//  CreateNewPostController.swift
//  Speak now
//
//  Created by Nha T.Tran on 6/14/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateNewPostController: UIViewController {

    
    @IBOutlet var avatar: UIImageView!
    
    @IBOutlet var username: UILabel!
    
    @IBOutlet var txtContent: UITextField!
    
    @IBOutlet var viewAddPhoto: UIView!
    
    @IBOutlet var btnAddPhoto: UIImageView!
    
    
    @IBOutlet var choosenImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initShow()
        initUser()
        // Do any additional setup after loading the view.
    }

    func initShow(){
                
        txtContent.layer.borderWidth = 1
        txtContent.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        
        viewAddPhoto.layer.borderWidth = 1
        viewAddPhoto.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        
    }
    
    func initUser(){
        
        let user = Auth.auth().currentUser
        
        Database.database().reference().child("user_profile").child((user?.uid)!).observeSingleEvent(of: .value, with:{ (snapshot) in
            
            let userDict = snapshot.value as! [String:AnyObject]
                
            let _username = userDict["username"] as! String
            let url = userDict["profile_pic"]
            let imgUrl =  URL(string: url as! String)
            let data = try? Data(contentsOf: imgUrl!)
                    
            if let imageData = data {
                let profilePic = UIImage(data: data!)
                self.avatar.image = profilePic
                        
            }
            self.username.text = _username
                    
            
        })
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
