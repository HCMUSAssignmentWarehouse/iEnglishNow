//
//  FindVC.swift
//  EnglishNow
//
//  Created by Nha T.Tran on 5/20/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class FindVC: UIViewController {

    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var btnFind: UIButton!
    
    @IBOutlet weak var btnFindBackground: UIImageView!
    @IBOutlet weak var lblSlogan: UILabel!
    @IBOutlet weak var pop: UIView!
    var userDic = NSDictionary()
    var databaseRef = Database.database().reference()
    var currentUser = Auth.auth().currentUser
    var userArray = [AnyObject]()
    var userNameArray = [String]()
    var matched = false
    var sessionId: String!
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User.current.reviews.count == 0 && !User.current.isSpeaker {
            fake()
        }
        
        //btnFind.layer.cornerRadius = btnFind.frame.height / 2
        
        if !User.current.isSpeaker {
            //lblSlogan.text = "WSString.matchViewLearnerTitle"
        } else {
            //lblSlogan.text = "WSString.matchViewSpeakerTitle"
        }
        
        //Popular()
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }
    
    
    @IBAction func btnFindOnTouch(_ sender: Any) {
        if !matched {
            //            Singleton.fakeData()
            matched = true
            
            btnFindBackground.image = #imageLiteral(resourceName: "findingBgButton")
            
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.blurView.alpha = 1
                self.lblSlogan.textColor = #colorLiteral(red: 0.4950980392, green: 0.5, blue: 0.5, alpha: 1)
                
                self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: (self.tabBarController?.tabBar.frame.origin.x)!, y: (self.tabBarController?.tabBar.frame.height)!)
                
            }, completion: nil)
            
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.fromValue = 0
            animation.toValue = CGFloat(M_PI * 2.0)
            animation.duration = 1
            animation.repeatCount = Float.infinity
            btnFindBackground.layer.add(animation, forKey: "rotate")
            
            btnFind.setTitle("Finding", for: .normal)
            
            FirebaseClient.shared.onMatch(completion: {(session, token) in
                self.sessionId = session
                self.token = token
                //self.performSegue(withIdentifier: SegueIdentifier.SegueCall, sender: nil)
            })
        } else {
            matched = false
            
            if User.current.isSpeaker {
                FirebaseClient.shared.removeHandleLearnerAvailable()
            } else {
                FirebaseClient.shared.removeHandleSpeakerAvailable()
            }
            
            btnFindBackground.image = #imageLiteral(resourceName: "findBgButton")
            
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.blurView.alpha = 0
                self.lblSlogan.textColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
                self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: (self.tabBarController?.tabBar.frame.origin.x)!, y: 0)
            }, completion: nil)
            
            btnFind.setTitle("Find", for: .normal)
        }
    }

    
    
    // MARK: - Functions
    
    func find(){
        self.databaseRef.child("user_profile").observeSingleEvent(of: .value, with:{snapshot in
            self.userDic = snapshot.value as! NSDictionary
            
            for (userId, details) in self.userDic {
                let name = (details as AnyObject).object(forKey: "name") as! String
                let connections = (details as AnyObject).object(forKey: "connections") as! NSDictionary
                
                for (deviceId, connection) in connections{
                    
                    if ((connection as AnyObject).object(forKey: "online") as! Bool){
                        (details as AnyObject).setValue(true, forKey: "online")
                    }else{
                        (details as AnyObject).setValue(false, forKey: "online")
                    }
                    
                }
                
                if (self.currentUser?.uid != userId as! String){
                    (details as AnyObject).setValue(userId, forKey: "uid")
                    self.userArray.append(details as AnyObject)
                }
                
                self.userNameArray.append(name)
                
            }
        })
    }
    
    func Popular(){
        
        let bounds = UIScreen.main.bounds
        var width = bounds.size.width
        var height = bounds.size.height
        
        if UIScreen.main.bounds.height > UIScreen.main.bounds.width {
            width = bounds.size.width
            height = bounds.size.height
        } else {    // in landscape
            height = bounds.size.width
            width = bounds.size.height
        }
        
        /*let circle = view;//Pop is a UIView
         
         circle?.bounds = CGRect(x: width/2 - 50,y: height/2 - 50, width: 100, height: 100);
         circle?.frame = CGRect(x: width/2 - 50,y: height/2 - 50, width:100,height: 100);
         
         circle?.layoutIfNeeded()*/
        
        let shapeLayer = CAShapeLayer()
        
        let circlePath1 = UIBezierPath(arcCenter: CGPoint(x: width/2,y: height/2), radius: CGFloat(90), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        shapeLayer.path = circlePath1.cgPath
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor(red:122/255,green:138/255,blue:143/255,alpha:1.0).cgColor
        //you can change the line width
        shapeLayer.lineWidth = 4.0
        view.layer.addSublayer(shapeLayer)
        
        var progressCircle = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: width/2,y: height/2), radius: CGFloat(90), startAngle: CGFloat(-M_PI/2), endAngle:CGFloat(M_PI * 2), clockwise: true)
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor(red:72/255,green:184/255,blue:173/255,alpha:1.0).cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 4.0
        
        view.layer.addSublayer(progressCircle)
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        progressCircle.add(animation, forKey: "ani")
    }
    
    
    func loadDB(){
        let user_type = UserDefaults.standard.string(forKey: "Keys.type")
        if user_type != nil{
            //            let objects = try! realm.objects(User.self)
            //            if objects.count > 0{
            //                User.current = objects.first!
            //                try! realm.write {
            User.current.review = Review()
            //                }
            if user_type == "learner"{
                User.current.type = UserType.learner
                
            }
            else{
                User.current.type = UserType.speaker
            }
            //            }
        }
        
    }
    
    func fake() {
        let stats1 = Rating()
        stats1.listening = 4
        stats1.pronounciation = 3
        stats1.fluency = 3
        stats1.vocabulary = 3
        let review1 = Review()
        review1.ratings = stats1
        review1.partner = "Keny N"
        review1.photoPartner = "https://firebasestorage.googleapis.com/v0/b/shareandlearn-17cc0.appspot.com/o/avatar2.png?alt=media&token=0f8e2df3-440d-4e21-b66b-dc639675c5cc"
        review1.comment = "You have good listening skill, it will perfect if you foncus on your pronounciation."
        
        let stats2 = Rating()
        stats2.listening = 3
        stats2.pronounciation = 3
        stats2.fluency = 3
        stats2.vocabulary = 3
        let review2 = Review()
        review2.ratings = stats2
        review2.partner = "Linda"
        review2.photoPartner = "https://firebasestorage.googleapis.com/v0/b/shareandlearn-17cc0.appspot.com/o/avatar1.png?alt=media&token=f061c825-2c70-4942-bcf0-054932ef3c32"
        review2.comment = "Your english speaking is good, you know alot of idoms. Hope to see you!"
        
        let stats3 = Rating()
        stats3.listening = 4
        stats3.pronounciation = 1
        stats3.fluency = 4
        stats3.vocabulary = 4
        let review3 = Review()
        review3.ratings = stats3
        review3.partner = "YoMi"
        review3.photoPartner = "https://firebasestorage.googleapis.com/v0/b/shareandlearn-17cc0.appspot.com/o/avatar3.png?alt=media&token=e845ae6d-3909-4025-b0ef-16c9892775e7"
        review3.comment = "Your english skill is good. You should spend more time."
        
        User.current.reviews.append(review3)
        User.current.reviews.append(review2)
        User.current.reviews.append(review1)
        User.current.conversations = 3
    }

}
