//
//  FindVC.swift
//  Speak now
//
//  Created by Nha T.Tran on 5/20/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class FindVC: UIViewController {

    
    @IBOutlet weak var pop: UIView!
    var userDic = NSDictionary()
    var databaseRef = Database.database().reference()
    var currentUser = Auth.auth().currentUser
    var userArray = [AnyObject]()
    var userNameArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        Popular()
        // Do any additional setup after loading the view.
    }
    
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
