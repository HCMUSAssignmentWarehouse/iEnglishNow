//
//  HomeTimeLineVC.swift
//  Speak now
//
//  Created by Nha T.Tran on 5/21/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class HomeTimeLineVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    //MARK: -declare
    @IBOutlet var btnMenu: UIBarButtonItem!
        
    @IBOutlet weak var table: UITableView!
    
    var statusList: [Status] = [Status]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        initShow()
        loadData()
        
        // Do any additional setup after loading the view.
    }

    //MARK: -hamburger menu
    override func viewDidAppear(_ animated: Bool) {
        
        if  revealViewController() != nil {
            btnMenu.target = self.revealViewController()
            btnMenu.action = "revealToggle:"
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
        
        
    }
    
  //MARK: -init to show
    func initShow(){
        table.delegate = self
        table.dataSource = self
    }
    
    //MARK: -load data
    func loadData(){
            
        let queryRef = Database.database().reference().child("status").observe(.value, with: { (snapshot) -> Void in
                
            self.statusList.removeAll()
            
            //go to each status
            for item in snapshot.children {
            let status = (item as! DataSnapshot).value as! [String:AnyObject]
                
                
            // if status have enough child (it means no error appear)
            if status.count >= FirebaseUtils.numberChildStatus - 1{
                let user = status["user"] as! String
                let content = status["content"] as! String
                let time = status["time"] as! TimeInterval
                let likeNumber = status["like_number"] as! Int
                let username = status["username"] as! String
                
                var avatar: UIImage?
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
                        
                if let url = status["avatar"] {
                    if let imgUrl =  URL(string: url as! String){
                        let data = try? Data(contentsOf: imgUrl)
                                
                        if let imageData = data {
                            let profilePic = UIImage(data: data!)
                            avatar = profilePic
                        }
                                
                    }
                }
                
                //if no avatar -> set default avatar
                if avatar == nil{
                    avatar = UIImage(named: "sample.jpg")
                }
                
                var isUserLiked: Bool = false
                
                if (status.index(forKey: "like") != nil) {
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
                    
                    //if photo is nil -> can't constructure with a nil param -> call constructure without photo
                    self.statusList.append(Status(statusId: (item as! DataSnapshot).key , user: user ,username: username, avatar: avatar!, content: content, time: time, likeNumber: likeNumber , isUserLiked: isUserLiked))
                } else {
                    
                    //call constructure with photo
                    self.statusList.append(Status(statusId: (item as! DataSnapshot).key , user: user , username: username, avatar: avatar! , content: content, time: time, photo: photo!, likeNumber: likeNumber , isUserLiked: isUserLiked))
                }
                        
                self.table.reloadData()
                        
            }
                    
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: -table datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath ) as! CellOfTimeLineVC
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        cell.layer.cornerRadius = 15
        
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
        
        if status.photo != nil {
            cell.photo.isHidden = false
            cell.photoBigHeightAnchor?.isActive = true
            cell.photoSmallHeightAnchor?.isActive = false
            cell.photo.image = status.photo
        }else {
            cell.photo.isHidden = true
            cell.photoSmallHeightAnchor?.isActive = true
            cell.photoBigHeightAnchor?.isActive = false
        }
        
        if status.isUserLiked == true {
            cell.btnLike.setBackgroundImage(UIImage(named: "liked.png"), for: UIControlState.normal)
        } else {
            cell.btnLike.setBackgroundImage(UIImage(named: "like.png"), for: UIControlState.normal)
        }
        
        
        return cell

    }
    
    
    var selectedIndex: Int = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = statusList.count - 1 - indexPath.row
        performSegue(withIdentifier: "SegueDetailStatus", sender: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    //auto size of cell to fit content
    override func viewWillAppear(_ animated: Bool) {
        self.table.estimatedRowHeight = 200
        self.table.rowHeight = UITableViewAutomaticDimension
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueDetailStatus" {
            let des = segue.destination as! DetailStatusVC
            des.status = statusList[selectedIndex]
        }
    }
    
}
