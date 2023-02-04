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
        
        let context = CoreDataManager.instance.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Customer", in: context)
        self.init(entity: entity!, insertInto: context)
        
    }
    
}
