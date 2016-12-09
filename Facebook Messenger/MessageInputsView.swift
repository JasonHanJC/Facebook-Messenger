//
//  MessageInputView.swift
//  Facebook Messenger
//
//  Created by Juncheng Han on 12/8/16.
//  Copyright © 2016 Juncheng Han. All rights reserved.
//

import UIKit

class MessageInputsView: UIView {
    
    let placeHolder: UITextField = {
        let textField = UITextField()
        textField.text = "Type a message..."
        textField.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
        textField.isUserInteractionEnabled = false
        textField.isEnabled = false
        return textField
    }()
    
    let inputTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    let topBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(placeHolder)
        addSubview(inputTextView)
        addSubview(sendButton)
        addSubview(topBorderView)
    }
    
    override func layoutSubviews() {
        
        addConstraintsWithFormat("H:|-8-[v0(200)]", views: placeHolder)
        addConstraintsWithFormat("V:|-4-[v0]-4-|", views: placeHolder)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-[v1(60)]-8-|", views: inputTextView, sendButton)
        addConstraintsWithFormat("V:|-4-[v0]-4-|", views: inputTextView)
        addConstraintsWithFormat("V:|-4-[v0]-4-|", views: sendButton)
        
        addConstraintsWithFormat("H:|[v0]|", views: topBorderView)
        addConstraintsWithFormat("V:|[v0(0.5)]", views: topBorderView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Message Inputs View deinited")
    }
}
