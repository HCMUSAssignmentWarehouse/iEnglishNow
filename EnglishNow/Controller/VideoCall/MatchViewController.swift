//
//  MatchViewController.swift
//  EnglishNow
//
//  Created by GeniusDoan on 6/29/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation

class MatchViewController: UIViewController {
    @IBOutlet weak var matchButton: UIButton!
    @IBOutlet weak var matchButtonBgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blurView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User.current.reviews.count == 0 && !User.current.isSpeaker {
            fake()
        }
        
        // setup match button
        //        matchButton.layer.borderWidth = 3
        //        matchButton.layer.borderColor = #colorLiteral(red: 0, green: 0.6823529412, blue: 0.6431372549, alpha: 1).cgColor
        matchButton.layer.cornerRadius = matchButton.frame.height / 2
        //        matchButtonBgImageView.layer.cornerRadius = matchButtonBgImageView.frame.height / 2
        // set title
        if !User.current.isSpeaker {
            titleLabel.text = "WSString.matchViewLearnerTitle"
        } else {
            titleLabel.text = "WSString.matchViewSpeakerTitle"
        }
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var matched = false
    @IBAction func onMatchButton(_ sender: UIButton) {
        if !matched {
            //Singleton.fakeData()
            matched = true
            doAnimate(isMatching: matched)
            
            FirebaseClient.shared.onMatch(completion: {(session, token) in
                self.sessionId = session
                self.token = token
                print(session)
                print(token)
                self.doAnimate(isMatching: false) //TODO: Remove this when change to show review screen when end call
                self.performSegue(withIdentifier: SegueIdentifier.SegueCall, sender: nil)
            })
        } else {
            matched = false
            doAnimate(isMatching: matched)
        }
    }
    
    var sessionId: String!
    var token: String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.SegueCall {
            let callViewController = segue.destination as! CallViewController
            callViewController.sessionId = sessionId
            callViewController.token = token
        }
    }
    
    func doAnimate(isMatching: Bool) {
        if isMatching {
            matchButtonBgImageView.image = #imageLiteral(resourceName: "findingBgButton")
            
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.blurView.alpha = 1
                self.titleLabel.textColor = #colorLiteral(red: 0.4950980392, green: 0.5, blue: 0.5, alpha: 1)
                
                self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: (self.tabBarController?.tabBar.frame.origin.x)!, y: (self.tabBarController?.tabBar.frame.height)!)
                
            }, completion: nil)
            
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.fromValue = 0
            animation.toValue = CGFloat(M_PI * 2.0)
            animation.duration = 1
            animation.repeatCount = Float.infinity
            matchButtonBgImageView.layer.add(animation, forKey: "rotate")
            
            matchButton.setTitle("Finding", for: .normal)
        }
        else {
            if User.current.isSpeaker {
                FirebaseClient.shared.removeHandleLearnerAvailable()
            } else {
                FirebaseClient.shared.removeHandleSpeakerAvailable()
            }
            
            matchButtonBgImageView.image = #imageLiteral(resourceName: "findBgButton")
            
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.blurView.alpha = 0
                self.titleLabel.textColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
                self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: (self.tabBarController?.tabBar.frame.origin.x)!, y: 0)
            }, completion: nil)
            
            matchButton.setTitle("Find", for: .normal)
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
        review1.partner = "Wonder woman"
        review1.photoPartner = "https://firebasestorage.googleapis.com/v0/b/chat-app-d989a.appspot.com/o/sample%2Fwonderwoman-1280-9amembargo-1488818748850_1280w.jpg?alt=media&token=2920dcff-af19-49cd-9321-4142cca59ae8"
        review1.comment = "You have good listening skill, it will perfect if you foncus on your pronounciation."
        
        let stats2 = Rating()
        stats2.listening = 3
        stats2.pronounciation = 3
        stats2.fluency = 3
        stats2.vocabulary = 3
        let review2 = Review()
        review2.ratings = stats2
        review2.partner = "Jack"
        review2.photoPartner = "https://firebasestorage.googleapis.com/v0/b/chat-app-d989a.appspot.com/o/sample%2Fpirates-of-the-caribbean_640x480_41447300092.jpg?alt=media&token=b240b121-084b-4fc8-b5cf-212c66e47ee2"
        review2.comment = "Your english speaking is good, you know alot of idoms. Hope to see you!"
        
        let stats3 = Rating()
        stats3.listening = 4
        stats3.pronounciation = 1
        stats3.fluency = 4
        stats3.vocabulary = 4
        let review3 = Review()
        review3.ratings = stats3
        review3.partner = "King Arthur"
        review3.photoPartner = "https://firebasestorage.googleapis.com/v0/b/chat-app-d989a.appspot.com/o/%25252Fsample%25252F%2F368AC57500000578-3705178-image-m-14_1469315018652.jpg?alt=media&token=2d8d2ba3-f1f0-430c-bbbd-0c6c217c6b03"
        review3.comment = "Your english skill is good. You should spend more time."
        
        User.current.reviews.append(review3)
        User.current.reviews.append(review2)
        User.current.reviews.append(review1)
        User.current.conversations = 3
    }
}
