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
    
    func createData(data: UserLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) {
        // Create context from container
        let managedContext = appDelegate.persistentContainer.viewContext
               
        // Declare an entity and create new record
//        let userEntity = NSEntityDescription.entity(forEntityName: "JobsLocal", in: managedContext)!
        let userEntity = NSEntityDescription.insertNewObject(forEntityName: "UsersLocal", into: managedContext)
//        let userEntity = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        
        print(data.userSkills.joined(separator: "-"))
        
        userEntity.setValue(data.fullname, forKey: "fullname")
        userEntity.setValue(data.userGraduation, forKey: "userGraduation")
        userEntity.setValue(data.userOccupation, forKey: "userOccupation")
        userEntity.setValue(data.userSkills.joined(separator: "-"), forKey: "userSkills")
        userEntity.setValue(data.userImage, forKey: "userImage")
    
        do {
            try managedContext.save()
            completionBlock("Success Save Data!")
            print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last!);
        } catch let error as NSError {
            completionBlock("\(error)")
        }
        
        // Prepare Request of type NSFetchRequest
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "JobsLocal")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "fullname") as! String)
                print(data.value(forKey: "userGraduation") as! String)
                print(data.value(forKey: "userOccupation") as! String)
                print(data.value(forKey: "userSkills") as! [String])
            }
        } catch {
            print("failed")
        }
    }
}

protocol LocalJobDataDelegate {
    func createData(data: UserLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) -> Void
    func deleteData(data: Admin, _ appDelegate: AppDelegate, completionBlock: @escaping(String) -> Void) -> Void
}
