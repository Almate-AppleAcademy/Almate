//
//  LocalNews.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 13/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation
import CoreData

class LocalNews: LocalNewsDataDelegate{
    func readDataLocal(_ appDelegate: AppDelegate, completionBlock: @escaping ([NewsLikeLocal]) -> Void) {
        // Create context from container
        let managedContext = appDelegate.persistentContainer.viewContext
        // Prepare Request of type NSFetchRequest
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsLocal")
        var dataNews: [NewsLikeLocal] = []
        do {
             let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                dataNews.append(
                    NewsLikeLocal(postId: data.value(forKey: "postId") as! String)
                )
            }
            print(dataNews)
            completionBlock(dataNews)
        } catch {
            print("gatot")
        }
    }
    
    func createData(data: NewsLikeLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) {
         // Create context from container
               let managedContext = appDelegate.persistentContainer.viewContext
               
               // Declare an entity and create new record
               let newsEntity = NSEntityDescription.entity(forEntityName: "NewsLocal", in: managedContext)!
                let news = NSManagedObject(entity: newsEntity, insertInto: managedContext)
        news.setValue(data.postId, forKey: "postId")
        
        do {
            try managedContext.save()
            completionBlock("Success Save Data!")
        } catch {
            completionBlock("\(error)")
        }
    }
    
    func deleteData(data: NewsLikeLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) {
         let managedContext = appDelegate.persistentContainer.viewContext
               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsLocal")
               fetchRequest.predicate = NSPredicate(format: "postId =  %@", "\(data.postId)")
        do {
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("could'nt save cause \(error), \(error.userInfo)")
            }
        } catch {
            print(error)
        }
    }
    
    
}

protocol LocalNewsDataDelegate {
    func readDataLocal(_ appDelegate: AppDelegate, completionBlock: @escaping([NewsLikeLocal]) -> Void) -> Void
    func createData(data: NewsLikeLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) -> Void
    func deleteData(data: NewsLikeLocal, _ appDelegate: AppDelegate, completionBlock: @escaping(String) -> Void) -> Void
}
