//
//  SlideMenuViewController.swift
//  EnglishNow
//
//  Created by Nha T.Tran on 6/17/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SlideMenuViewController: UIViewController {

    
    @IBOutlet var avatar: UIImageView!
    
    @IBOutlet var txtUsername: UILabel!
    
    @IBOutlet var txtEmail: UILabel!
    
    @IBOutlet var btnProfile: UIButton!
    
    
    @IBOutlet var btnLogout: UIButton!
    
    
    @IBAction func btnLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let user = Auth.auth().currentUser
            
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "PrepareStoryboard") as UIViewController
            self.present(controller, animated: true, completion: nil)
            
        } catch {
            print("there was an rror when logout!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initShowUser()
        btnProfile.layer.shadowOpacity = 1
        
        btnLogout.layer.shadowOpacity = 1
        
        avatar.layer.cornerRadius = 62
        avatar.layer.masksToBounds = true
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor(red: 255, green: 111, blue: 0, alpha: 1.0).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initShowUser(){
        if let user = Auth.auth().currentUser{
            
            let queryRef = Database.database().reference().child("user_profile/\(user.uid)").observe(.value, with: { (snapshot) -> Void in
                
                if let dictionary = snapshot.value as? [String:Any] {
                    let username = dictionary["username"] as? String ?? ""
                    let email = dictionary["email"] as? String ?? ""

                    self.txtEmail.text = email
                    self.txtUsername.text = username
                    
                    if let url = dictionary["profile_pic"] {
                        if let imgUrl =  URL(string: url as! String){
                            let data = try? Data(contentsOf: imgUrl)
                            
                            if let imageData = data {
                                let profilePic = UIImage(data: data!)
                                self.avatar.image = profilePic
                            }
                            
                        }
                        
                        
                    }
                    
                    
                }
                
            })
        }
        
    }

    

}
