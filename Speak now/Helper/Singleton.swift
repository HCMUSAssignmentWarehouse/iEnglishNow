//
//  Singleton.swift
//  Speak now
//
//  Created by GeniusDoan on 6/29/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation

class Singleton{
    static let sharedInstance = Singleton()
    var partner: User!
    var tabBarController:UITabBarController!
    var tokBoxSessionId: String!
    var tokBoxApiKey: String! = "45900432"
    //var historyViewController: HistoryViewController?
    //var profileViewController: GProfileViewController?
    
    /*
    func reloadProfileHistory() {
        if let hvc = historyViewController {
            hvc.historyTableView.reloadData()
        }
        
        if let pvc = profileViewController {
            pvc.profileTableView.reloadData()
        }
    }
     */
    
    fileprivate init(){
        partner = User()
        //createTabbar()
    }
    
    static let skills:[String] = ["Listening", "Pronounciation", "Fluency", "Vocabulary"]
    
    /*
    fileprivate func createTabbar(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondStoryboard = UIStoryboard(name: "Second", bundle: nil)
        
        let matchVC = mainStoryboard.instantiateViewController(withIdentifier: "MatchVC") as! MatchViewController
        
        //nowPlayingViewController.API_URL = URLs.NOWPLAYING_URL
        matchVC.tabBarItem.title = "Find"
        matchVC.tabBarItem.image = UIImage(named: "search")
        
        let historyVC = secondStoryboard.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryViewController
        historyVC.tabBarItem.title = "My Conversations"
        historyVC.tabBarItem.image = UIImage(named: "history")
        
        let profileVC = secondStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! GProfileViewController
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(named: "profile")
        
        
        tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBar") as!UITabBarController
        tabBarController.viewControllers = [matchVC, historyVC, profileVC]
    }
    
    static func getTabbar() -> UITabBarController{
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondStoryboard = UIStoryboard(name: "Second", bundle: nil)
        
        let matchVC = mainStoryboard.instantiateViewController(withIdentifier: "MatchVC") as! MatchViewController
        
        //nowPlayingViewController.API_URL = URLs.NOWPLAYING_URL
        matchVC.tabBarItem.title = "Find"
        matchVC.tabBarItem.image = UIImage(named: "search")
        
        let historyVC = secondStoryboard.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryViewController
        historyVC.tabBarItem.title = "My Conversations"
        historyVC.tabBarItem.image = UIImage(named: "history")
        
        let profileVC = secondStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! GProfileViewController
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(named: "profile")
        
        
        let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBar") as!UITabBarController
        tabBarController.tabBar.tintColor = UIColor(colorLiteralRed: 14/255, green: 160/255, blue: 147/255, alpha: 1)
        tabBarController.viewControllers = [matchVC, historyVC, profileVC]
        return tabBarController
    }
     */
}
