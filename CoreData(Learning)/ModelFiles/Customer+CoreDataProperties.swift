//
//  Customer+CoreDataProperties.swift
//  CoreData(Learning)
//
//  Created by Mac on 04.02.2023.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var name: String?
    @NSManaged public var info: String?
    @NSManaged public var orders: NSSet?

}

// MARK: Generated accessors for orders
extension Customer {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Order)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Order)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}

extension Customer : Identifiable {

}
