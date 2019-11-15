//
//  LocalJob.swift
//  Almate
//
//  Created by Qiarra on 15/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation
import CoreData

class LocalJob: LocalJobDataDelegate {
    
    func deleteData(data: Admin, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "JobsLocal")
        fetchRequest.predicate = NSPredicate(format: "emailAdmin =  %@", "jobEmail1@gg.me")
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
    
    func createData(data: Admin, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) {
        // Create context from container
        let managedContext = appDelegate.persistentContainer.viewContext
               
        // Declare an entity and create new record
        let userEntity = NSEntityDescription.entity(forEntityName: "JobsLocal", in: managedContext)!
        let job = NSManagedObject(entity: userEntity, insertInto: managedContext)
        job.setValue(data.email, forKey: "emailAdmin")
        job.setValue(data.password, forKey: "passwordAdmin")
        
        do {
            try managedContext.save()
            completionBlock("Success Save Data!")
        } catch let error as NSError {
            completionBlock("\(error)")
        }
        
        // Prepare Request of type NSFetchRequest
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "JobsLocal")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "emailAdmin") as! String)
                print(data.value(forKey: "passwordAdmin") as! String)
            }
        } catch {
            print("failed")
        }
    }
}

protocol LocalJobDataDelegate {
    func createData(data: Admin, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) -> Void
    func deleteData(data: Admin, _ appDelegate: AppDelegate, completionBlock: @escaping(String) -> Void) -> Void
}
