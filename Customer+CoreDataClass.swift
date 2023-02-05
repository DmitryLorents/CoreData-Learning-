//
//  Customer+CoreDataClass.swift
//  CoreData(Learning)
//
//  Created by Mac on 04.02.2023.
//
//

import Foundation
import CoreData


public class Customer: NSManagedObject {
    
    convenience init() {
        let coreDataManager = CoreDataManager.instance
        self.init(entity: CoreDataManager.instance.entityForName(name: .customer), insertInto: coreDataManager.viewContext)
    }
    
}
