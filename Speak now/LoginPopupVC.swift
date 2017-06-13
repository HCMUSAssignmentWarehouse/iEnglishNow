//
//  LoginPopupVC.swift
//  Speak now
//
//  Created by Nha T.Tran on 5/20/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase


class LoginPopupVC: UIViewController {

    
    @IBOutlet var txtWelcomeName: UILabel!
    
    @IBAction func btnCancel(_ sender: Any) {
        var storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainScreenVC") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func btnDismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var LoginSuccessView: UIView!
    
    
    @IBOutlet weak var AvatarView: UIView!
    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBAction func btnFind(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SegueFind", sender: self)
        
    }
    
   
    
    let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        initShow()
        initUsername()
        //view.backgroundColor = UIColor.clear
        //view.isOpaque = false
        // Do any additional setup after loading the view.
    }

    func initUsername(){
        if let user = Auth.auth().currentUser{
            
            
            let queryRef = Database.database().reference().child("user_profile/\(user.uid)").observe(.value, with: { (snapshot) -> Void in
                
                if let dictionary = snapshot.value as? [String:Any] {
                    let username = dictionary["username"] as? String ?? ""
                    self.txtWelcomeName.text = username
                    
                    let url = dictionary["profile_pic"]
                    
                    let imgUrl =  URL(string: url as! String)
                    print("profile_pic: \(imgUrl)")
                    let data = try? Data(contentsOf: imgUrl!)
                    
                    if let imageData = data {
                        let profilePic = UIImage(data: data!)
                        self.avatar.image = profilePic
                    }
                }
                
            })
        }
        
    }
    
    
    func initShow(){
        LoginSuccessView.layer.cornerRadius = 5
        LoginSuccessView.layer.borderWidth = 1
        LoginSuccessView.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        AvatarView.layer.borderWidth = 1
        AvatarView.layer.cornerRadius = 60
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 60
        
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch!.location(in: self.view)
        if shapeLayer.path!.contains(point) {
            print ("We tapped the square")
        }
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
