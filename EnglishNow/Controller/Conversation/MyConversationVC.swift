//
//  MyConversationVC.swift
//  EnglishNow
//
//  Created by Nha T.Tran on 5/21/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import UIKit
import Cosmos

class MyConversationVC: UIViewController {
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet var btnMenu: UIBarButtonItem!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initShow()
        
        if  revealViewController() != nil {
            btnMenu.target = self.revealViewController()
            btnMenu.action = "revealToggle:"
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
            Singleton.sharedInstance.conversationViewController = self
        }
        
        // Do any additional setup after loading the view.
    }
    
    func initShow(){
        table.delegate = self
        table.dataSource = self
        table.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        let nc = segue.destination as! UINavigationController
        let vc = nc.topViewController as! DetailViewController
        let index = table.indexPathForSelectedRow?.row
        vc.review = User.current.reviews[index!]
    }
}


extension MyConversationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.HistoryCell, for: indexPath ) as! HistoryCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        cell.layer.cornerRadius = 15
        
        var rating: Double = User.current.reviews[indexPath.row].rating
        if rating == 0 {
            rating = Double(arc4random_uniform(5) + 1)
            User.current.reviews[indexPath.row].rating = rating
        }
        cell.cosmos.rating = rating
        cell.nameLabel?.text = User.current.reviews[indexPath.row].partner
        var profileImg: String = User.current.reviews[indexPath.row].photoPartner
        if profileImg.isEmpty {
            cell.profileImageView?.image = UIImage(named: ResourceName.coverPlaceholder)
        }
        else {
            cell.profileImageView.setImageWith(URL(string: profileImg)!)
        }
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.current.reviews.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.SegueDetail, sender: self)
    }
}
