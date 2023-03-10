//
//  CoreDataManager.swift
//  CoreData(Learning)
//
//  Created by Mac on 04.02.2023.
//

import Foundation
import CoreData
import UIKit

enum EntityNames: String {
    case order = "Order"
    case services = "Services"
    case rowOfOrder =  "RowOfOrder"
    case customer = "Customer"
}

class CoreDataManager {
    static let instance = CoreDataManager()
    
    // MARK: - Core Data stack
    lazy var viewContext = persistentContainer.viewContext
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreData_Learning_")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK: - CoreData Methods
    
    public func entityForName(name: EntityNames) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: name.rawValue, in: self.viewContext)!
    }
    
    //FetcheedResultcontroller for entity name
    
    public func fetchedResultController(entityName: EntityNames, keyForSort: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.rawValue)
        let sortdescriptor = NSSortDescriptor(key: keyForSort, ascending: true)
        fetchRequest.sortDescriptors = [sortdescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    // MARK: - Core Data Saving support

    public func saveContext () {
        let context = viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
