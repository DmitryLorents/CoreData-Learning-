//
//  Order+CoreDataClass.swift
//  CoreData(Learning)
//
//  Created by Mac on 04.02.2023.
//
//

import Foundation
import CoreData


public class Order: NSManagedObject {
    
    class func getRowsOfOrder(order: Order) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.rowOfOrder.rawValue)
        let sortDescriptor = NSSortDescriptor(key: "service.name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let predicate = NSPredicate(format: "%K == %@", "order", order)
        fetchRequest.predicate = predicate
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    convenience init() {
        let coreDataManager = CoreDataManager.instance
        self.init(entity: coreDataManager.entityForName(name: .order), insertInto: coreDataManager.viewContext)
    }
}
