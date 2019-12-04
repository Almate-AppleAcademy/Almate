//
//  LocalUser.swift
//  Almate
//
//  Created by Qiarra on 13/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation
import CoreData

class LocalUser: LocalUserDataDelegate {
    
    func deleteData(data: LocalUsers, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersLocal")
        fetchRequest.predicate = NSPredicate(format: "idUser =  %@", "\(data.idUser!)")
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
    
    func createData(data: LocalUsers, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) {
        // Create context from container
        let managedContext = appDelegate.persistentContainer.viewContext
               
        // Declare an entity and create new record
        let userEntity = NSEntityDescription.entity(forEntityName: "UsersLocal", in: managedContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(data.idUser, forKey: "idUser")
        user.setValue(data.email, forKey: "emailUser")
        user.setValue(data.name, forKey: "nameUser")
        user.setValue(data.generation, forKey: "genUser")
        user.setValue(data.occupation, forKey: "occuUser")
        user.setValue("okelah", forKey: "skillsUser")
        
        do {
            try managedContext.save()
            completionBlock("Success Save Data!")
        } catch let error as NSError {
            completionBlock("\(error)")
        }
        
        // Prepare Request of type NSFetchRequest
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersLocal")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "idUser") as! String)
            }
        } catch {
            print("failed")
        }
    }
}

protocol LocalUserDataDelegate {
    func createData(data: LocalUsers, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) -> Void
    func deleteData(data: LocalUsers, _ appDelegate: AppDelegate, completionBlock: @escaping(String) -> Void) -> Void
}
