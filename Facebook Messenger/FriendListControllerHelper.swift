//
//  FriendListControllerHelper.swift
//  Facebook Messenger
//
//  Created by Juncheng Han on 12/7/16.
//  Copyright © 2016 Juncheng Han. All rights reserved.
//

import UIKit
import CoreData

extension FriendListController {
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "zuckprofile"
            
            let markMessage = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            markMessage.date = Date() as NSDate?
            markMessage.friend = mark
            markMessage.text = "Hello, my name is Mark. Nice to meet you."
            
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steve_profile"
            
            let steveMessage = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            steveMessage.date = Date() as NSDate?
            steveMessage.friend = steve
            steveMessage.text = "Apple creats great products for the world"
            
            // save the objectsc
            do {
                try(context.save())
            } catch let err {
                print(err)
            }
            
            // messages = [markMessage, steveMessage]

        }
        
        loadData()
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            
            do {
                messages = try(context.fetch(fetchRequest)) as? [Message]
            } catch let err {
                print(err)
            }
        }
    }
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                
                let entityNames = ["Friend", "Message"]
                
                for entityName in entityNames {
                    
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    let objects = try(context.fetch(fetchRequest)) as? [NSManagedObject]
                    
                    for object in objects! {
                        context.delete(object)
                    }
                }
            } catch let err {
                print(err)
            }
        }
    }
}
