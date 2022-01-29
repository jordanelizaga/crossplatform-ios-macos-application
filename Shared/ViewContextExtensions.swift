//
//  ViewContextExtensions.swift
//  ExpenseTrackingTool
//
//  Created by Jordan Elizaga on 1/27/22.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func genericDebugSave() {
        do {
            
            if self.hasChanges {
                try self.save()
            }
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
     }
}


