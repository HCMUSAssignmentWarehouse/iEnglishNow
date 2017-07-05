//
//  DetailViewController.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/3/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation


class DetailViewController: UIViewController {
    
    var review:Review?
    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNib()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.reloadData()
    }
    
    
    func loadNib(){
        detailTableView.register(UINib(nibName: CellIdentifier.RatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.RatingCell)
        
        detailTableView.register(UINib(nibName: CellIdentifier.AverageRatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.AverageRatingCell)
        
        detailTableView.register(UINib(nibName: CellIdentifier.ReviewCommentCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.ReviewCommentCell)
        
        detailTableView.register(UINib(nibName: CellIdentifier.PlayRecordCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.PlayRecordCell)
        
        detailTableView.register(UINib(nibName: CellIdentifier.SpeakerRatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.SpeakerRatingCell)
        
    }
    @IBAction func onBackButton(_ sender: UIBarButtonItem) {
        Recorder.shared.pause()
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(User.current.type == UserType.learner){
            return 4
        }
        else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            if User.current.type == UserType.learner{
                return 4
            }
        default:
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if User.current.type == UserType.learner{
            switch  indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.AverageRatingCell) as! AverageRatingCell
                cell.totalRatingsLabel.isHidden = true
                cell.review = review
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.RatingCell) as! RatingCell
                cell.skillLabel.text = Singleton.skills[indexPath.row]
                switch indexPath.row {
                case 0:
                    var listenRate: Double = (review?.ratings?.listening)!
                    if listenRate != 0 {
                        cell.ratingControl.rating = listenRate
                    }
                case 1:
                    var pronounciationRate: Double = (review?.ratings?.pronounciation)!
                    if pronounciationRate != 0 {
                        cell.ratingControl.rating = pronounciationRate
                    }
                case 2:
                    var fluencyRate: Double = (review?.ratings?.fluency)!
                    if fluencyRate != 0 {
                        cell.ratingControl.rating = fluencyRate
                    }
                case 3:
                    var vocabularyRate: Double = (review?.ratings?.vocabulary)!
                    if vocabularyRate != 0 {
                        cell.ratingControl.rating = vocabularyRate
                    }
                default:
                    break
                }
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ReviewCommentCell) as! ReviewCommentCell
                cell.commentTextView.text = review?.comment
                cell.commentTextView.isEditable = false
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.PlayRecordCell) as! PlayRecordCell
                cell.fileName = review?.recordFileName
                print(cell.fileName)
                return cell
            default:
                return UITableViewCell()
            }
        }
        else{
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.SpeakerRatingCell) as! SpeakerRatingCell
                cell.ratingControl.rating = (review?.rating)!
                cell.totalRatingsLabel.isHidden = true
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ReviewCommentCell) as! ReviewCommentCell
                cell.commentTextView.text = review?.comment
                cell.commentTextView.isEditable = false
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.PlayRecordCell) as! PlayRecordCell
                cell.fileName = review?.recordFileName
                print(cell.fileName)
                return cell
            default:
                return UITableViewCell()
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if User.current.type == UserType.learner{
            switch indexPath.section {
            case 0:
                return 90
            case 2:
                return 120
            case 3:
                return 80
            default:
                return 40
            }
        }
        else{
            switch indexPath.section {
            case 0:
                return 80
            case 1:
                return 120
            case 2:
                return 80
            default:
                return 60
            }
        }
    }
}
