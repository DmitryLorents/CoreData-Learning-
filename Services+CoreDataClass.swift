//
//  Services+CoreDataClass.swift
//  CoreData(Learning)
//
//  Created by Mac on 04.02.2023.
//
//

import Foundation
import CoreData


public class Services: NSManagedObject {
    convenience init() {
        let coreDataManager = CoreDataManager.instance
        self.init(entity: coreDataManager.entityForName(name: .services), insertInto: coreDataManager.viewContext)
    }
}
