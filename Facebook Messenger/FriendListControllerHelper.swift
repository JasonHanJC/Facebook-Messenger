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
            
            let steveMessage1 = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            steveMessage1.date = Date().addingTimeInterval(-3 * 60) as NSDate?
            steveMessage1.friend = steve
            steveMessage1.text = "Apple"
            
            let steveMessage2 = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            steveMessage2.date = Date().addingTimeInterval(-2 * 60) as NSDate?
            steveMessage2.friend = steve
            steveMessage2.text = "Apple creats great products for the world"
            
            let steveMessage3 = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            steveMessage3.date = Date().addingTimeInterval(-1 * 60) as NSDate?
            steveMessage3.friend = steve
            steveMessage3.text = "Apple creats great products for the world, Apple creats great products for the world, Apple creats great products for the world, Apple creats great products for the world,  Apple creats great products for the world"
            
            let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Trump"
            donald.profileImageName = "donald_trump_profile"
            
            let donaldMessage1 = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            donaldMessage1.date = Date().addingTimeInterval(-5 * 60) as NSDate?
            donaldMessage1.friend = donald
            donaldMessage1.text = "You are fired!"
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            gandhi.name = "Mahatma Gandhi"
            gandhi.profileImageName = "gandhi"
            
            let gandhiMessage1 = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            gandhiMessage1.date = Date().addingTimeInterval(-60 * 55 * 60) as NSDate?
            gandhiMessage1.friend = gandhi
            gandhiMessage1.text = "I love peace!"
            
            let hillary = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            hillary.name = "Hillary Clinton"
            hillary.profileImageName = "hillary_profile"
            
            let hillaryMessage1 = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            hillaryMessage1.date = Date().addingTimeInterval(-60 * 5555 * 60) as NSDate?
            hillaryMessage1.friend = hillary
            hillaryMessage1.text = "Please vote for me"
            // save the objectsc
            do {
                try(context.save())
            } catch let err {
                print(err)
            }
        }
        
        loadData()
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            if let friends = fetchFriends() {
                
                // remenber to init the array
                messages = [Message]()
                
                for friend in friends {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    fetchRequest.fetchLimit = 1
                    
                    do {
                        let fetchedMessages = try(context.fetch(fetchRequest)) as? [Message]
                        messages?.append(contentsOf: fetchedMessages!)
                    } catch let err {
                        print(err)
                    }
                }
                
                messages = messages?.sorted(by: { (item1, item2) -> Bool in
                    return item1.date?.compare(item2.date as! Date) == .orderedDescending
                })
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
    
    func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            do {
                return try(context.fetch(fetchRequest)) as? [Friend]
            } catch let err {
                print(err)
            }
        }
        
        return nil;
    }
}
