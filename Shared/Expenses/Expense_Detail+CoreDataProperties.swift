//
//  Expense_Detail+CoreDataProperties.swift
//  ExpenseTrackingMulti
//
//  Created by Jordan Elizaga on 1/28/22.
//
//

import Foundation
import CoreData


extension Expense_Detail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense_Detail> {
        return NSFetchRequest<Expense_Detail>(entityName: "Expense_Detail")
    }

    @NSManaged public var purpose: String
    @NSManaged public var id: UUID?
    @NSManaged public var cost: NSDecimalNumber
    @NSManaged public var expense: Expense
    @NSManaged public var category: Expense_Category

}

extension Expense_Detail : Identifiable {

}
