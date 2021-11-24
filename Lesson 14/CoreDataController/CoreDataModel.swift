//
//  CoreDataModel.swift
//  Lesson 14
//
//  Created by Kirill Davydov on 23.11.2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataPersistance {
    static var shared = CoreDataPersistance()

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func addTask(_ name: String) {
        
        let moc = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: moc)!
        
        let task = NSManagedObject(entity: entity, insertInto: moc)
        
        task.setValue(name, forKey: "name")
        
        do {
            try moc.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getTasks() -> [NSManagedObject]{
        var finalTasks: [NSManagedObject] = []
        
        let moc = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            finalTasks = try moc.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return finalTasks
    }
    
    func deleteAllTasks() {
        let moc = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Task")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try myPersistentStoreCoordinator.execute(deleteRequest, with: moc)
//        } catch let error as NSError {
//            // TODO: handle the error
//        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            fetchRequest.returnsObjectsAsFaults = false

            do
            {
                let results = try moc.fetch(fetchRequest)
                for managedObject in results
                {
                    let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                    moc.delete(managedObjectData)
                }
            } catch let error as NSError {
                print("Detele all my CoreData error : \(error) \(error.userInfo)")
            }
    }
}
