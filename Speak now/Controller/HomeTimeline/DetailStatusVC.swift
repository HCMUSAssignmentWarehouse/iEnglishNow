//
//  DetailStatusVC.swift
//  Speak now
//
//  Created by Nha T.Tran on 6/18/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DetailStatusVC: UIViewController , UITableViewDelegate, UITableViewDataSource{

    //MARK: -declare
    var commentList: [Comment] = [Comment]()
    var status: Status?
    
    @IBOutlet var mainView: UIView!
    
    
    
    //MARK: -setup view
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
    
    let btnComment: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named:"iconComment.png")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    let btnLike: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named:"like.png")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    let txtComment: UILabel = {
        let label = UILabel()
        label.text = "Comment"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "Georgia" , size: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let txtLike: UILabel = {
        let label = UILabel()
        label.text = "like"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "Georgia" , size: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    let txtUserName: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name:"Georgia-Bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let txtTime: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Georgia" , size: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    
    let txtLikeNumber: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "Georgia" , size: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    
    
    
    let actionView: UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
 
    let inputCommentView: UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    
    let txtContent: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "Georgia" , size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let txtInputComment: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter your comment"
        txt.textAlignment = NSTextAlignment.left
        txt.font = UIFont(name: "Georgia" , size: 17)
        txt.translatesAutoresizingMaskIntoConstraints = false
        
        return txt
    }()

    let btnPostComment: UIButton = {
        
        let btn = UIButton()
        btn.setTitle("Post", for: .normal)
        btn.backgroundColor = UIColor(red: 30/255, green: 136/255, blue: 229/255, alpha: 1.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    
    let commentTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false

        return table
    }()
    
    var inputBigHeightAnchor: NSLayoutConstraint?
    var inputSmallHeightAnchor: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if status != nil {
            initShow()
        }
        // Initialization code
    }
    
    
    //MARK: -init to show
    func initShow(){
        
        
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 10
        
        
        mainView.addSubview(avatar)
        mainView.addSubview(txtUserName)
        mainView.addSubview(txtTime)
        mainView.addSubview(txtContent)
        mainView.addSubview(photo)
        mainView.addSubview(actionView)
        mainView.addSubview(txtLikeNumber)
        mainView.addSubview(inputCommentView)
        mainView.addSubview(commentTable)

        inputCommentView.addSubview(txtInputComment)
        inputCommentView.addSubview(btnPostComment)

        commentTable.delegate = self
        commentTable.dataSource = self
        commentTable.register(CommentCell.self, forCellReuseIdentifier: "Cell")

        
        actionView.addSubview(btnComment)
        actionView.addSubview(btnLike)
        actionView.addSubview(txtComment)
        actionView.addSubview(txtLike)
        
        
        avatar.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        avatar.topAnchor.constraint(equalTo: mainView.topAnchor, constant: -40).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 82).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 74).isActive = true
        
        txtUserName.topAnchor.constraint(equalTo: mainView.topAnchor, constant: -40).isActive = true
        txtUserName.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 8).isActive = true
        txtUserName.heightAnchor.constraint(equalToConstant: 24).isActive = true
        txtUserName.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -8).isActive = true
        
        txtTime.topAnchor.constraint(equalTo: txtUserName.bottomAnchor, constant: 2).isActive = true
        txtTime.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 8).isActive = true
        txtTime.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -8).isActive = true
        txtTime.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        txtContent.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16).isActive = true
        txtContent.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        txtContent.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -8).isActive = true
        if status?.photo == nil {
            photo.heightAnchor.constraint(equalToConstant: 1).isActive = true
            photo.heightAnchor.constraint(equalToConstant: 150).isActive = false

        } else {
            photo.heightAnchor.constraint(equalToConstant: 150).isActive = true
            photo.heightAnchor.constraint(equalToConstant: 1).isActive = false
        }
        
        
        photo.topAnchor.constraint(equalTo: txtContent.bottomAnchor, constant: 8).isActive = true
        photo.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        txtLikeNumber.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 16).isActive = true
        txtLikeNumber.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        txtLikeNumber.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        actionView.topAnchor.constraint(equalTo: txtLikeNumber.bottomAnchor, constant: 16).isActive = true
        actionView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16).isActive = true
        actionView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        actionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        actionView.layer.borderWidth = 1
        actionView.layer.borderColor = UIColor(red: 229/255, green: 232/255, blue: 232/255, alpha: 1.0).cgColor
        
        btnLike.topAnchor.constraint(equalTo: actionView.topAnchor, constant: 8).isActive = true
        btnLike.leftAnchor.constraint(equalTo: actionView.leftAnchor, constant: 32).isActive = true
        btnLike.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btnLike.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btnLike.bottomAnchor.constraint(equalTo: actionView.bottomAnchor, constant: -8).isActive = true

        txtLike.topAnchor.constraint(equalTo: actionView.topAnchor, constant: 8).isActive = true
        txtLike.leftAnchor.constraint(equalTo: btnLike.rightAnchor, constant: 4).isActive = true
        txtLike.widthAnchor.constraint(equalToConstant: 32).isActive = true
        txtLike.heightAnchor.constraint(equalToConstant: 32).isActive = true
        txtLike.bottomAnchor.constraint(equalTo: actionView.bottomAnchor, constant: -8).isActive = true
        
        btnComment.topAnchor.constraint(equalTo: actionView.topAnchor, constant: 8).isActive = true
        btnComment.rightAnchor.constraint(equalTo: txtComment.leftAnchor, constant: -4).isActive = true
        btnComment.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btnComment.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btnComment.bottomAnchor.constraint(equalTo: actionView.bottomAnchor, constant: -8).isActive = true
      
        txtComment.topAnchor.constraint(equalTo: actionView.topAnchor, constant: 8).isActive = true
        txtComment.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -56).isActive = true
        txtComment.heightAnchor.constraint(equalToConstant: 32).isActive = true
        txtComment.bottomAnchor.constraint(equalTo: actionView.bottomAnchor, constant: -8).isActive = true
        
        inputCommentView.topAnchor.constraint(equalTo: actionView.bottomAnchor, constant: 8).isActive = true
        inputCommentView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        inputCommentView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16).isActive = true
        inputCommentView.layer.borderWidth = 1
        inputCommentView.layer.borderColor = UIColor(red: 229/255, green: 232/255, blue: 232/255, alpha: 1.0).cgColor
        inputCommentView.heightAnchor.constraint(equalToConstant: 36).isActive = true

        txtInputComment.topAnchor.constraint(equalTo: inputCommentView.topAnchor).isActive = true
        txtInputComment.leftAnchor.constraint(equalTo: inputCommentView.leftAnchor).isActive = true
        txtInputComment.bottomAnchor.constraint(equalTo: inputCommentView.bottomAnchor).isActive = true
        txtInputComment.rightAnchor.constraint(equalTo: btnPostComment.leftAnchor).isActive = true

        btnPostComment.topAnchor.constraint(equalTo: inputCommentView.topAnchor ).isActive = true
        btnPostComment.rightAnchor.constraint(equalTo: inputCommentView.rightAnchor).isActive = true
        btnPostComment.bottomAnchor.constraint(equalTo: inputCommentView.bottomAnchor).isActive = true
        btnPostComment.widthAnchor.constraint(equalToConstant: 56).isActive = true
        
        
        
        
        commentTable.topAnchor.constraint(equalTo: inputCommentView.bottomAnchor, constant: 8).isActive = true
        commentTable.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        commentTable.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16).isActive = true
        commentTable.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8).isActive = true
        
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 5
        
        avatar.image = status?.avatar
        txtUserName.text = status?.username
        
        var milliseconds = status?.time
        
        let date = NSDate(timeIntervalSince1970: TimeInterval(milliseconds!))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        txtTime.text = formatter.string(from: date as Date)
        
        txtContent.text = status?.content
        
        var likenumber:Int = (status?.likeNumber)!
        txtLikeNumber.text = "\(likenumber)" + " LIKES"
        photo.image = status?.photo
        
        if (status?.isUserLiked)! {
            btnLike.image = UIImage(named: "liked.png")
        }
        
        btnLike.isUserInteractionEnabled = true
        let likeTapRecognizer = UITapGestureRecognizer(target:self, action: #selector(tappedLikeImage))
        btnLike.addGestureRecognizer(likeTapRecognizer)
        txtLike.isUserInteractionEnabled = true
        txtLike.addGestureRecognizer(likeTapRecognizer)
        
        btnComment.isUserInteractionEnabled = true
        let commentTapRecognizer = UITapGestureRecognizer(target:self, action: #selector(tappedCommentImage))
        btnComment.addGestureRecognizer(commentTapRecognizer)
        
        txtComment.isUserInteractionEnabled = true
        txtComment.addGestureRecognizer(commentTapRecognizer)
        
        avatar.isUserInteractionEnabled = true
        let avatarTapRecognizer = UITapGestureRecognizer(target:self, action: #selector(tappedAvatarImage))
        avatar.addGestureRecognizer(avatarTapRecognizer)

        self.mainView.isUserInteractionEnabled = true
        let mainViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.mainView.addGestureRecognizer(mainViewTapGesture)
        
        loadComment()
        
        onClickBtnLike()
    }
    
    
    //MARK: -tap event
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    

    
    func tappedAvatarImage(gestureRecognizer: UIGestureRecognizer){
        performSegue(withIdentifier: "SegueProfile", sender: self)
    }
    
    func onClickBtnLike (){
        btnPostComment.addTarget(self, action: #selector(onPost), for: .touchUpInside)
    }
    
    func tappedCommentImage(gestureRecognizer: UIGestureRecognizer){
        
        txtInputComment.becomeFirstResponder()
    }
    
    func tappedLikeImage(gestureRecognizer: UIGestureRecognizer){
        
        if (status?.isUserLiked == false){
            
            if let user = Auth.auth().currentUser{
                Database.database().reference().child("status").child((status?.statusId)!).child("like").child(user.uid).setValue(true)
                
                var likeNumber = (status?.likeNumber)! + 1
                Database.database().reference().child("status").child((status?.statusId)!).child("like_number").setValue(likeNumber)
                
                txtLikeNumber.text = "\(likeNumber)" + " LIKES"
                
                print("status?.user: \(status?.user)")
                print("status?.statusId: \(status?.statusId)")
                print("user.uid: \(user.uid)")
                Database.database().reference().child("user_profile").child((status?.user)!).child("status").child((status?.statusId)!).child("like").child(user.uid).setValue(true)
                Database.database().reference().child("user_profile").child((status?.user)!).child("status").child((status?.statusId)!).child("like_number").setValue(likeNumber)
                status?.isUserLiked = true
                status?.likeNumber = likeNumber
                
                btnLike.image =  UIImage(named: "liked.png") //, for: UIControlState.normal)
            }
            
            
        }
        else {
            
            if let user = Auth.auth().currentUser{
                Database.database().reference().child("status").child((status?.statusId)!).child("like").child(user.uid).setValue(false)
                
                var likeNumber = (status?.likeNumber)! - 1
                
                Database.database().reference().child("status").child((status?.statusId)!).child("like_number").setValue(likeNumber)
                
                txtLikeNumber.text = "\(likeNumber)" + " LIKES"
                
                
                Database.database().reference().child("user_profile").child((status?.user)!).child("status").child((status?.statusId)!).child("like").child(user.uid).setValue(false)
                Database.database().reference().child("user_profile").child((status?.user)!).child("status").child((status?.statusId)!).child("like_number").setValue(likeNumber)
                
                
                status?.isUserLiked = false
                status?.likeNumber = likeNumber
                
                
                btnLike.image =  UIImage(named: "like.png") //, for: UIControlState.normal)
            }
            
            
        }
        
        
    }
    
    

    //MARK: -post event
    func onPost(btn: UIButton) {
        if (txtInputComment.text != ""){
            
            if let user = Auth.auth().currentUser{
                
                let queryRef = Database.database().reference().child("user_profile/\(user.uid)").observe(.value, with: { (snapshot) -> Void in
                    
                    if let dictionary = snapshot.value as? [String:Any] {
                        let username = dictionary["username"] as? String ?? ""
                        
                        var useravatarUrl: String = ""
                        var userAvatar:UIImage = UIImage(named:"sample.jpg")!

                        if dictionary.index(forKey: "profile_pic") != nil {
                            useravatarUrl = dictionary["profile_pic"] as! String
                            
                            if let imgUrl =  URL(string: useravatarUrl as! String){
                                let data = try? Data(contentsOf: imgUrl)
                                
                                if let imageData = data {
                                    let profilePic = UIImage(data: data!)
                                    userAvatar = profilePic!
                                }
                                
                            }
                        }
                        
                        let ref = Database.database().reference().child("status").child((self.status?.statusId)!).child("comment").childByAutoId()
                        ref.child("userId").setValue(user.uid)
                        ref.child("username").setValue(username)
                        ref.child("avatar").setValue(useravatarUrl)
                        ref.child("content").setValue(self.txtInputComment.text)
                        ref.child("time").setValue(Date.timeIntervalBetween1970AndReferenceDate)
                        
                        self.txtInputComment.text = ""
                        
                        
                        
                        self.commentList.append(Comment(userId: user.uid, username: username,avatar: userAvatar,content:self.txtInputComment.text!, commentId: ref.key,time: Date.timeIntervalBetween1970AndReferenceDate))
                        self.commentTable.reloadData()
                        
                    }
                })

                
                
                
                
            }
            
            
        }
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.mainView.endEditing(true)
    }
    
    
    //MARK: -load data
        func loadComment(){
        let ref = Database.database().reference().child("status").child((self.status?.statusId)!).observe(.value, with: { (snapshot) -> Void in
            
            let status = (snapshot as! DataSnapshot).value as! [String:AnyObject]
            if (status.index(forKey: "comment") != nil) {
                let comment = ((snapshot as! DataSnapshot).childSnapshot(forPath: "comment") as! DataSnapshot)
                self.commentList.removeAll()
                for item in comment.children {
                    let dictionary = (item as! DataSnapshot).value as! [String:AnyObject]
             
                    if dictionary.count == FirebaseUtils.numberChildComment {
                        let userId = dictionary["userId"] as! String
                        let username = dictionary["username"] as! String
                        let content = dictionary["content"] as! String
                        let time = dictionary["time"] as! TimeInterval
                        let commentId = (item as! DataSnapshot).key as! String
                        var userAvatar: UIImage = UIImage(named: "sample.jpg")!
                        if let url = dictionary["avatar"] {
                            if let imgUrl =  URL(string: url as! String){
                                let data = try? Data(contentsOf: imgUrl)
                        
                                if let imageData = data {
                                    let profilePic = UIImage(data: data!)
                                    userAvatar = profilePic!
                                }
                        
                            }
                        }

                        self.commentList.append(Comment(userId: userId, username: username,avatar: userAvatar,content:content, commentId: commentId,time: time))
                        self.commentTable.reloadData()
                    }
                }
            }
        })

    }
   
    
    //MARK: -table datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath ) as! CommentCell
        
        let image = UIImageView()
        image.frame = CGRect(x: 4, y: 4, width: 36, height: 36)
        image.image = commentList[indexPath.row].avatar
        image.translatesAutoresizingMaskIntoConstraints = false

        
        let _txtUsername = UILabel()
        _txtUsername.text = "username"
        _txtUsername.frame = CGRect(x: 48, y: 4, width: cell.frame.width - 56 ,  height: 24)
        _txtUsername.textAlignment = NSTextAlignment.left
        _txtUsername.font = UIFont(name:"Georgia-Bold", size: 18.0)
        _txtUsername.text = commentList[indexPath.row].username
        
        let _txtComment = UILabel()
        _txtComment.text = ""
        _txtComment.textAlignment = NSTextAlignment.left
        _txtComment.sizeToFit()
        _txtComment.frame = CGRect(x: 48, y: 32, width: cell.frame.width - 56 ,  height: cell.frame.height - 40)
        _txtComment.font = UIFont(name: "Georgia" , size: 16)
        _txtComment.text = commentList[indexPath.row].content
        _txtComment.numberOfLines = 10
        
        cell.addSubview(_txtComment)
        cell.addSubview(_txtUsername)
        cell.addSubview(image)
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueProfile" {
            let des = segue.destination as! ProfileVC
            des.currentID = (status?.user)!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
