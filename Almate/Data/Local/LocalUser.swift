//
//  LocalUser.swift
//  Almate
//
//  Created by Qiarra on 13/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class LocalUser: LocalUserDataDelegate {
    
    func deleteData(data: UserLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersLocal")
        fetchRequest.predicate = NSPredicate(format: "firstName =  %@", "\(data.fullname)")
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
        let userEntity = NSEntityDescription.entity(forEntityName: "UsersLocal", in: managedContext)!
        let job = NSManagedObject(entity: userEntity, insertInto: managedContext)
        job.setValue(data.fullname, forKey: "fullname")
        job.setValue(data.userGraduation, forKey: "userGraduation")
        job.setValue(data.userOccupation, forKey: "userOccupation")
        job.setValue(data.userSkills, forKey: "userSkills")
        print(data.userImage)
        job.setValue(data.userImage, forKey: "userImage")
        
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

protocol LocalUserDataDelegate {
    func createData(data: UserLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) -> Void
    func deleteData(data: UserLocal, _ appDelegate: AppDelegate, completionBlock: @escaping(String) -> Void) -> Void
}
