//
//  Expense+CoreDataProperties.swift
//  ExpenseTrackingMulti (iOS)
//
//  Created by Jordan Elizaga on 1/28/22.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var cost: NSDecimalNumber?
    @NSManaged public var date_created: Date?
    @NSManaged public var date_transaction: Date
    @NSManaged public var id: UUID?
    @NSManaged public var purpose: String
    @NSManaged public var short_description: String?
    @NSManaged public var categories: NSSet?

}

// MARK: Generated accessors for categories
extension Expense {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Expense_Category)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: Expense_Category)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

extension Expense : Identifiable {

}
