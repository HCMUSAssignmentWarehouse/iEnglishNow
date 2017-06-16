//
//  ProfileVCViewController.swift
//  Speak now
//
//  Created by Nha T.Tran on 5/21/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ProfileVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate,  UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var avatar: UIImageView!
    
    @IBOutlet var numberView: UIView!
    
    @IBOutlet var titleStats: UIView!
    
    @IBOutlet var txtYourRating: UILabel!
    
    @IBOutlet var yourRatingView: UIView!
    
    @IBOutlet var imgLogout: UIImageView!
    
    @IBOutlet var username: UILabel!
    
    @IBOutlet var txtDrinksNumber: UILabel!
   
    @IBOutlet var txtConversationsNumber: UILabel!
    
    @IBOutlet var tableStatus: UITableView!
    
    @IBOutlet var btnStar: UIButton!
    
    @IBOutlet var btnStars: [UIButton]!
    
    var skills: [Skill] = [Skill]()
    
    let deviceID = UIDevice.current.identifierForVendor?.uuidString
    
    var currentID: String = ""
    
    var statusList:[Status] = [Status]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skills.append(Listening())
        skills.append(Speaking())
        skills.append(Pronunciation())

        initShow()

        
        if currentID == ""{
            
            //to make sure user is loaded before show
            if let user = Auth.auth().currentUser{
                loadProfile(userid: ((user.uid) as? String)!)
            }
        } else {
            imgLogout.isHidden = true
            loadProfile(userid: "")
        }
        
    }

    func loadStatus(userid: String,  username: String, avatar: UIImage){
        
        
        if currentID == ""{
            currentID = userid
        }
        
        Database.database().reference().child("user_profile/\(currentID)").child("status").observe(.value, with: { (snapshot) -> Void in
            
            self.statusList.removeAll()
            
            //go  to each status
            for item in snapshot.children {
                
                let status = (item as! DataSnapshot).value as! [String:AnyObject]
                
                if status.count >= FirebaseUtils.numberChildUserStatus - 1{
                    let content = status["content"] as! String
                    let time = status["time"] as! TimeInterval
                    let likeNumber = status["like_number"] as! Int
                    
                    var photo:UIImage?
                    
                    if let url = status["photo"] {
                        if let imgUrl =  URL(string: url as! String){
                            let data = try? Data(contentsOf: imgUrl)
                            
                            if let imageData = data {
                                let profilePic = UIImage(data: data!)
                                photo = profilePic
                            }
                            
                        }
                    }
                    
                    
                    var isUserLiked: Bool = false
                    
                    if status.count == FirebaseUtils.numberChildUserStatus {
                        let likes = ((item as! DataSnapshot).childSnapshot(forPath: "like") as! DataSnapshot).value as! [String:AnyObject]
                        
                        if let user = Auth.auth().currentUser{
                            if (likes.index(forKey: user.uid) != nil) {
                                let isLiked = likes[user.uid]as! Bool
                                if isLiked == true {
                                    isUserLiked = true
                                }
                            }
                        }
                        
                    }
                    
                
                    
                    if photo == nil{
                        //if photo is nil -> call constructure has photo failed -->
                        //call constructure without photo
                        self.statusList.append(Status(statusId: (item as! DataSnapshot).key , user: self.currentID ,username: username, avatar: avatar, content: content, time: time, likeNumber: likeNumber , isUserLiked: isUserLiked))
                    } else {
                        
                        //call constructure has photo
                        self.statusList.append(Status(statusId: (item as! DataSnapshot).key , user: self.currentID , username: username, avatar: avatar , content: content, time: time, photo: photo!, likeNumber: likeNumber , isUserLiked: isUserLiked))
                    }
                    
                    
                    self.tableStatus.reloadData()

                }
                
                
                
            }

        
        })
        

    }
    
    func loadProfile(userid: String){
        
        
        if currentID == ""{
            currentID = userid
        }
        let queryRef = Database.database().reference().child("user_profile/\(currentID)").observe(.value, with: { (snapshot) -> Void in
                
            if let dictionary = snapshot.value as? [String:Any] {
                let drinks = dictionary["drinks"] as? Int ?? 0
                let conversations = dictionary["conversations"] as? Int ?? 0

                self.txtDrinksNumber.text = "\(drinks)"
                self.txtConversationsNumber.text = "\(conversations)"
                
                let username = dictionary["username"] as? String ?? ""
                self.username.text = username
                
                if let url = dictionary["profile_pic"] {
                    if let imgUrl =  URL(string: url as! String){
                        let data = try? Data(contentsOf: imgUrl)
                        
                        if let imageData = data {
                            let profilePic = UIImage(data: data!)
                            self.avatar.image = profilePic
                        }
                        
                    }
                    
                    
                }
                
                if dictionary.count == FirebaseUtils.numberChildOfUser {
                    
                    self.statusList.removeAll()
                    
                    self.loadStatus(userid: userid,  username: username, avatar: self.avatar.image!)
                    
                }

            }
        })
        
        //load data of level
        Database.database().reference().child("user_profile/\(currentID)").child("skill").observe(.value, with: { (snapshot) -> Void in
            
            let child = snapshot.value as! [String:Any]
            let listening = child["listening skill"] as? Int ?? 0
            let speaking = child["speaking skill"] as? Int ?? 0
            let pronunciation = child["pronunciation skill"] as? Int ?? 0
                    
            for button in self.btnStars{
                if (button.tag <= 5 && (button.tag - 1) % 5 < listening){
                    //selected
                    button.setTitleColor(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), for: .normal)
                }else  if (button.tag <= 10 && button.tag > 5 && (button.tag - 1) % 5 < speaking){
                    button.setTitleColor(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), for: .normal)
                }else if (button.tag <= 15 && button.tag > 10 && (button.tag - 1) % 5 < pronunciation){
                    button.setTitleColor(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), for: .normal)
                }else{
                    //not selected
                    button.setTitleColor(UIColor.lightGray, for: .normal)
                }
            }
              
        })
        
    }
    
    
    func initShow(){
       avatar.layer.masksToBounds = true
      avatar.layer.cornerRadius = 68
        
        numberView.layer.borderWidth = 1
        numberView.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        numberView.layer.shadowColor = UIColor.black.cgColor
        numberView.layer.shadowOpacity = 0.5
        numberView.layer.shadowOffset = CGSize(width:0, height:1.75)
        numberView.layer.shadowRadius = 1.7
        numberView.layer.shadowPath = UIBezierPath(rect: numberView.bounds).cgPath
        numberView.layer.shouldRasterize = true
        
        txtYourRating.layer.cornerRadius = 15
        txtYourRating.layer.borderWidth = 4
        txtYourRating.layer.borderColor = UIColor(red:0, green:128/255, blue:128/255,alpha:1.0).cgColor
        
        yourRatingView.layer.borderWidth = 1
        yourRatingView.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        yourRatingView.layer.shadowColor = UIColor.black.cgColor
        yourRatingView.layer.shadowOpacity = 0.5
        yourRatingView.layer.shadowOffset = CGSize(width:0, height:1.75)
        yourRatingView.layer.shadowRadius = 1.7
        yourRatingView.layer.shadowPath = UIBezierPath(rect: numberView.bounds).cgPath
        yourRatingView.layer.shouldRasterize = true

        tableStatus.delegate = self
        tableStatus.dataSource = self
        
        
        setOnLogoutTapped()
        setOnAvatarTapped()
    }
    
    
    func setOnAvatarTapped(){
        avatar.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target:self, action: #selector(tappedAvatarImage))
        avatar.addGestureRecognizer(tapRecognizer)
    }
    
        
    func tappedAvatarImage(gestureRecognizer: UIGestureRecognizer){
        
      let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true,completion:nil)
            
        
    }
    
    
    func setOnLogoutTapped() {
        imgLogout.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target:self, action: #selector(tappedLogoutImage))
        imgLogout.addGestureRecognizer(tapRecognizer)
    }
    
    func tappedLogoutImage(gestureRecognizer:UIGestureRecognizer) {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        
        var selectedImageFromPicker: UIImage?
        
        if let editedimage = info["UIImagePickerControllerEditedImage"]{
            selectedImageFromPicker = editedimage as! UIImage
            print("edited!")
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"]{
            selectedImageFromPicker = originalImage as! UIImage
            print("original!")
        }
        
        if (selectedImageFromPicker != nil) {
            
        self.avatar.image = selectedImageFromPicker
        }
        

        let userRef = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
        
        var databaseRef = Database.database().reference()
        var storageRef = Storage.storage().reference()
        var currentUser = Auth.auth().currentUser
        
        if let imageData:NSData = UIImagePNGRepresentation(selectedImageFromPicker!)! as NSData?{
            let profilePicStorageRef = storageRef.child("user_profiles/\(currentUser?.uid)/profile_pic")
            let uploadTask = profilePicStorageRef.putData(imageData as Data, metadata:nil){metadata, error in
                if (error == nil){
                    let downloadUrl = metadata?.downloadURL()
                    databaseRef.child("user_profile").child((currentUser?.uid)!).child("profile_pic").setValue(downloadUrl?.absoluteString)
                    
                    print("\(downloadUrl?.absoluteString)")
                    print("upload image success!")
                }else{
                    print(error?.localizedDescription)
                }
            }
        }
        
        dismiss(animated: true, completion: nil)

        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel!")
        dismiss(animated: true, completion: nil)
    }
    
    
    //TABLE STATUS
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath ) as! CellOfTimeLineVC
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        cell.layer.cornerRadius = 15
        
        if statusList.count > 0 {
            let status = statusList[statusList.count - 1 - indexPath.row]
            
            
            cell.status = status
            
            
            cell.txtContent.text = status.content
            let number:Int = status.likeNumber!
            cell.txtNumberOfLike.text = "\(number)"
            cell.avatar.image = status.avatar
            cell.txtName.text = status.username
            
            var milliseconds = status.time
            
            let date = NSDate(timeIntervalSince1970: TimeInterval(milliseconds!))
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale!
            cell.txtTime.text = formatter.string(from: date as Date)
            
            if status.isUserLiked == true {
                cell.btnLike.setBackgroundImage(UIImage(named: "liked.png"), for: UIControlState.normal)
            } else {
                cell.btnLike.setBackgroundImage(UIImage(named: "like.png"), for: UIControlState.normal)
            }
            

        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
}
