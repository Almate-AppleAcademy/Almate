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
    func readDataLocal(_ appDelegate: AppDelegate, completionBlock: @escaping ([UserLocal]) -> Void) {
        // Create context from container
        let managedContext = appDelegate.persistentContainer.viewContext
        // Prepare Request of type NSFetchRequest
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersLocal")
        var dataPeople: [UserLocal] = []
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                dataPeople.append(
                    UserLocal(fullname: data.value(forKey: "fullname") as! String, userGraduation: data.value(forKey: "userGraduation") as! String, userOccupation: data.value(forKey: "userOccupation") as! String, userSkills: data.value(forKey: "userSkills") as! [NSString], userImage: data.value(forKey: "userImage") as! Data, userId: data.value(forKey: "userId") as! String)
                )
            }
            completionBlock(dataPeople)
        } catch {
            print("failed")
        }
    }
    
    func deleteData(data: UserLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersLocal")
        fetchRequest.predicate = NSPredicate(format: "fullname =  %@", "\(data.fullname)")
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
        job.setValue(data.userId, forKey: "userId")
        job.setValue(data.userImage, forKey: "userImage")
        
        do {
            try managedContext.save()
            completionBlock("Success Save Data!")
        } catch let error as NSError {
            completionBlock("\(error)")
        }
    }
}

protocol LocalUserDataDelegate {
    func createData(data: UserLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) -> Void
    func deleteData(data: UserLocal, _ appDelegate: AppDelegate, completionBlock: @escaping(String) -> Void) -> Void
    func readDataLocal(_ appDelegate: AppDelegate, completionBlock: @escaping([UserLocal]) -> Void) -> Void
}
