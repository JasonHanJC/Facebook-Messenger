//
//  MessageInputView.swift
//  Facebook Messenger
//
//  Created by Juncheng Han on 12/8/16.
//  Copyright © 2016 Juncheng Han. All rights reserved.
//

import UIKit

protocol MessageInputsDelegate: class {
    
    func messageInputsSendButtonPressed(_ messageText: String)
}

class MessageInputs: NSObject {
    
    weak var delegate: MessageInputsDelegate?
    
    let messageInputsView = MessageInputsView()
    
    override init() {
        super.init()
        
        messageInputsView.sendButton.addTarget(self, action: #selector(handleSendButtonPressed), for: .touchUpInside)
    }
    
    @objc private func handleSendButtonPressed(sender: UIButton) {
        if let message = messageInputsView.inputTextView.text {
            delegate?.messageInputsSendButtonPressed(message)
            messageInputsView.inputTextView.text = nil
            messageInputsView.placeHolder.isHidden = false
        }
    }
    
    deinit {
        //NotificationCenter.default.removeObserver(self)
        print("Message Inputs deinited")
    }
    
}

class MessageInputsView: UIView, UITextViewDelegate {
    
    //weak var delegate: MessageInputsViewDelegate?
    
    let placeHolder: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Type a message..."
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
        textLabel.isUserInteractionEnabled = false
        return textLabel
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
        let titleColor = UIColor.rgb(red: 0, green: 137, blue: 249, alpha: 1)
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
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        
        backgroundColor = .white
        
        addSubview(placeHolder)
        addSubview(inputTextView)
        addSubview(sendButton)
        addSubview(topBorderView)
    }
    
    @objc private func textDidChange() {
        placeHolder.isHidden = !inputTextView.text.isEmpty
    }
    
    override func layoutSubviews() {
        
        addConstraintsWithFormat("H:|-15-[v0(200)]", views: placeHolder)
        addConstraintsWithFormat("V:|-2-[v0]-6-|", views: placeHolder)
        
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
        NotificationCenter.default.removeObserver(self)
        print("Message Inputs View deinited")
    }
}
