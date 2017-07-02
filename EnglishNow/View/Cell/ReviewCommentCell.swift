//
//  ReviewCommentCell.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/3/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation

class ReviewCommentCell: UITableViewCell {
    @IBOutlet weak var commentTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        commentTextView.delegate = self
        commentTextView.text = "Your comment"
        commentTextView.textColor = UIColor.gray
        commentTextView.layer.borderColor = UIColor.gray.cgColor
        commentTextView.layer.borderWidth = 0.5
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension ReviewCommentCell:UITextViewDelegate{
    public func textViewDidEndEditing(_ textView: UITextView){
        Singleton.sharedInstance.partner.review?.comment = textView.text
        if textView.text == ""{
            commentTextView.text = "Your comment"
            commentTextView.textColor = UIColor.gray
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        Singleton.sharedInstance.partner.review?.comment = textView.text
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView){
        if textView.text == "Your comment"{
            textView.text = ""
            textView.textColor = UIColor.darkText
        }
    }
}
