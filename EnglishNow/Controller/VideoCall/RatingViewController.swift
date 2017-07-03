//
//  RatingViewController.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/3/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation

class RatingViewController: UIViewController {
    
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNib()
        NotificationCenter.default.addObserver(self, selector: #selector(RatingViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RatingViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.reloadData()
        //reviewTableView.estimatedRowHeight = 80
        //reviewTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func loadNib(){
        reviewTableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        reviewTableView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionCell")
        reviewTableView.register(UINib(nibName: "TipCell", bundle: nil), forCellReuseIdentifier: "TipCell")
        reviewTableView.register(UINib(nibName: "ReviewCommentCell", bundle: nil), forCellReuseIdentifier: "ReviewCommentCell")
        reviewTableView.register(UINib(nibName: "SubmitCell", bundle: nil), forCellReuseIdentifier: "SubmitCell")
    }
    
    func keyboardWillShow(notification: NSNotification) {
        /*bottomConstraint.constant = 250
         UIView.animate(withDuration: 0.3) {
         self.view.layoutIfNeeded()
         }*/
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/1.2
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        /*bottomConstraint.constant = 149
         UIView.animate(withDuration: 0.3) {
         self.view.layoutIfNeeded()
         }*/
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height/1.2
            }
        }
    }
}

extension RatingViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5 //Everyone can give gift
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
        if User.current.type == UserType.speaker{
            if section == 1{
                return 4
            }
        }
        */
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
                cell.nameLabel.text = Singleton.sharedInstance.partner.name
                cell.profileImageView.image = UIImage(named: Singleton.sharedInstance.partner.profilePhoto)
                cell.user = Singleton.sharedInstance.partner
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionCell
                cell.questionLabel.text = Singleton.skills[indexPath.row]
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TipCell") as! TipCell
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCommentCell") as! ReviewCommentCell
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitCell") as! SubmitCell
                cell.submitButton.addTarget(self, action: #selector(submitTouchDown(_:)), for: .touchDown)
                return cell
            default:
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 170
        case 1:
            return 70
        case 2:
            return 80
        case 4:
            return 65
        default:
            return 90
        }
        
    }
    
    func submitTouchDown(_ sender: UIButton){
        //send review to server
        Singleton.sharedInstance.partner.review?.partner = User.current.name
        Singleton.sharedInstance.partner.review.photoPartner = User.current.profilePhoto
        Singleton.sharedInstance.partner.review.recordFileName = Singleton.sharedInstance.tokBoxSessionId
        FirebaseClient.shared.commitReview(review: Singleton.sharedInstance.partner.review!)
        present(Singleton.getTabbar(), animated: true, completion: nil)
    }
}
