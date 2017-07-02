//
//  Dialog.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/1/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation
import Cosmos

class Dialog: UIView {
    @IBOutlet weak var partnerPhoto: UIImageView!
    @IBOutlet weak var partnerName: UILabel!
    @IBOutlet weak var partnerRating: CosmosView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var wraperDialog: UIView!
    @IBOutlet weak var indicatorWaitingConnection: UIActivityIndicatorView!
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "Dialog", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        wraperDialog.layer.cornerRadius = 6
        wraperDialog.layer.shadowColor = UIColor.black.cgColor
        wraperDialog.layer.shadowOpacity = 1
        wraperDialog.layer.shadowOffset = CGSize.zero
        wraperDialog.layer.shadowRadius = 5
        partnerPhoto.layer.cornerRadius = partnerPhoto.frame.height / 2
        startButton.layer.cornerRadius = 6
        startButton.isHidden = true
        
        partnerName.text = Singleton.sharedInstance.partner.name
        Singleton.sharedInstance.partner.setUserPhotoView(view: partnerPhoto)
        partnerRating.rating = Singleton.sharedInstance.partner.rating
        
        indicatorWaitingConnection.startAnimating()
        
        showAnimation()
    }
    
    func showStartButton() {
        startButton.isHidden = false
    }
    
    func showAnimation() {
        alpha = 0
        wraperDialog.transform = CGAffineTransform(scaleX: 3, y: 3)
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
        })
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: {
            self.wraperDialog.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    @IBAction func onTouchStartButton(_ sender: UIButton) {
        //TODO: Record
        //Record.shared.start(nameFile: Singleton.sharedInstance.sessionIdOpenTok)
        removeFromSuperview()
    }
    
}
