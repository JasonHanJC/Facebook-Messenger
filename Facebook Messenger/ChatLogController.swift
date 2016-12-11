//
//  ChatLogController.swift
//  Facebook Messenger
//
//  Created by Juncheng Han on 12/7/16.
//  Copyright © 2016 Juncheng Han. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var messages: [Message]?
    
    let messageInputs = MessageInputs()
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            messages = friend?.message?.allObjects as? [Message]
            messages = messages?.sorted(by: { (item1, item2) -> Bool in
                return item1.date?.compare(item2.date as! Date) == .orderedAscending
            })
        }
    }
    
    var inputsViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        tabBarController?.tabBar.isHidden = true

        self.collectionView!.register(ChatLogCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets(top: 64.0, left: 0.0, bottom: 49.0, right: 0.0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 64.0, left: 0.0, bottom: 49.0, right: 0.0)
        if let count = messages?.count {
            let indexPath = IndexPath(item: count - 1, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: false)
        }
        
        // MARK: setup inputsView
        messageInputs.delegate = self
        view.addSubview(messageInputs.messageInputsView)
        view.addConstraintsWithFormat("H:|[v0]|", views: messageInputs.messageInputsView)
        view.addConstraintsWithFormat("V:[v0(48)]", views: messageInputs.messageInputsView)
        
        inputsViewBottomConstraint = NSLayoutConstraint(item: messageInputs.messageInputsView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(inputsViewBottomConstraint!)
        
        setupNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("ChatLogController deinited")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowAndHide), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowAndHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    // MAKR: Keyboard notification
    @objc private func keyboardWillShowAndHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame: NSValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
            var keyboardRect = keyboardFrame.cgRectValue
            keyboardRect = view.convert(keyboardRect, from: nil)
            let yPosition = keyboardRect.origin.y
            let keyboardHeight = UIScreen.main.bounds.size.height - yPosition;
            
            let isKeyboardShow = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            inputsViewBottomConstraint?.constant = isKeyboardShow ? -keyboardHeight : 0
            UIView.animate(withDuration: 0, animations: { 
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func keyboardWillChangeFrame(notification: NSNotification) {
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatLogCell
    
        cell.message = messages?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = messages?[indexPath.item].text {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 20 + 8)

        }
        
        return CGSize(width: view.frame.width, height: 100)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
}

extension ChatLogController: MessageInputsDelegate {
    
    func messageInputsSendButtonPressed(_ messageText: String) {
        view.endEditing(true)
        
        
    }
}
