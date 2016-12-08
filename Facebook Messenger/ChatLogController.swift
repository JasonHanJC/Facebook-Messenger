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
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            messages = friend?.message?.allObjects as? [Message]
            messages = messages?.sorted(by: { (item1, item2) -> Bool in
                return item1.date?.compare(item2.date as! Date) == .orderedAscending
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(ChatLogCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.backgroundColor = .white

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
        cell.messageTextView.text = messages?[indexPath.item].text
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

}

class ChatLogCell: BaseCell {
    
    let messageTextView: UITextView = {
        let tv = UITextView();
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.text = "Sample message"
        return tv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(messageTextView)
        
        addConstraintsWithFormat("H:|[v0]|", views: messageTextView)
        addConstraintsWithFormat("V:|[v0]|", views: messageTextView)
        
    }
}
