//
//  ChatLogCell.swift
//  Facebook Messenger
//
//  Created by Juncheng Han on 12/9/16.
//  Copyright © 2016 Juncheng Han. All rights reserved.
//

import UIKit

class ChatLogCell: BaseCell {
    
    var message: Message? {
        didSet {
            messageTextView.text = message?.text
            
            if let messageText = message?.text {
                let size = CGSize(width: 250, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
                
                messageTextView.frame = CGRect(x: 42 + 8 + 2, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                textBubbleView.frame = CGRect(x: 42 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            }
            
            if message?.isSender == true {
                messageTextView.frame = CGRect(x: frame.width - 8 - messageTextView.frame.width + 4, y: 0, width: messageTextView.frame.width, height: messageTextView.frame.height)
                textBubbleView.frame = CGRect(x: frame.width - 8 - textBubbleView.frame.width, y: 0, width: textBubbleView.frame.width, height: textBubbleView.frame.height)
                
                textBubbleView.backgroundColor = UIColor.rgb(red: 0, green: 134, blue: 249, alpha: 1)
                messageTextView.textColor = .white
                
                profileImageView.isHidden = true
            } else {
                textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
                messageTextView.textColor = .black
                
                profileImageView.isHidden = false
                if let profileImageName = message?.friend?.profileImageName {
                    profileImageView.image = UIImage(named: profileImageName)
                }
            }
            
        }
    }
    
    let messageTextView: UITextView = {
        let tv = UITextView();
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.backgroundColor = .clear
        tv.text = "Sample message"
        tv.isEditable = false
        return tv
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        addConstraintsWithFormat("H:|-8-[v0(30)]", views: profileImageView)
        addConstraintsWithFormat("V:[v0(30)]-8-|", views: profileImageView)
        
    }
}
