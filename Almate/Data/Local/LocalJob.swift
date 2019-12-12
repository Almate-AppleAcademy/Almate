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
    func readDataPeople(_ appDelegate: AppDelegate, completionBlock: @escaping ([UserLocal]) -> Void) {
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
    
    
    func deleteData(data: JobLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "JobsLocal")
        fetchRequest.predicate = NSPredicate(format: "documentID =  %@", "\(data.documentID)")
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
    
    func createData(data: JobLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) {
        // Create context from container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Declare an entity and create new record
        //        let userEntity = NSEntityDescription.entity(forEntityName: "JobsLocal", in: managedContext)!
        let userEntity = NSEntityDescription.insertNewObject(forEntityName: "JobsLocal", into: managedContext)
        //        let userEntity = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        userEntity.setValue(data.companyImage, forKey: "companyImage")
        userEntity.setValue(data.companyLocation, forKey: "companyLocation")
        userEntity.setValue(data.companyName, forKey: "companyName")
        userEntity.setValue(data.jobTitle, forKey: "jobTitle")
        userEntity.setValue(data.documentID, forKey: "documentID")
        
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
                print(data.value(forKey: "companyImage") as! Data)
                print(data.value(forKey: "companyLocation") as! String)
                print(data.value(forKey: "companyName") as! String)
                print(data.value(forKey: "jobTitle") as! String)
            }
            print(result)
        } catch {
            print("failed")
        }
    }
    
    func readData(_ appDelegate: AppDelegate, completionBlock: @escaping ([JobLocal]) -> Void) {
        // Create context from container
        let managedContext = appDelegate.persistentContainer.viewContext
        // Prepare Request of type NSFetchRequest
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "JobsLocal")
        var dataJob: [JobLocal] = []
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                dataJob.append(
                    JobLocal(
                        jobTitle: data.value(forKey: "jobTitle") as! String,
                        companyName: data.value(forKey: "companyName") as! String,
                        companyLocation: data.value(forKey: "companyLocation") as! String,
                        companyImage: data.value(forKey: "companyImage") as! Data, documentID: data.value(forKey: "documentID") as! String)
                )
            }
            completionBlock(dataJob)
        } catch {
            print("failed")
        }
    }
    
}

protocol LocalJobDataDelegate {
    func createData(data: JobLocal, _ appDelegate: AppDelegate, completionBlock: @escaping (String) -> Void) -> Void
    func deleteData(data: JobLocal, _ appDelegate: AppDelegate, completionBlock: @escaping(String) -> Void) -> Void
    func readData(_ appDelegate: AppDelegate, completionBlock: @escaping([JobLocal]) -> Void) -> Void
    func readDataPeople(_ appDelegate: AppDelegate, completionBlock: @escaping([UserLocal]) -> Void) -> Void
}
