//
//  Persistence.swift
//  ExpenseTrackingTool
//
//  Created by Jordan Elizaga on 1/26/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let expense = Expense(context: viewContext)
            expense.date_created = Calendar.current.date(byAdding: .day, value: i, to: Date())
            expense.cost = NSDecimalNumber(integerLiteral: i)
            expense.purpose = String(i)
            print(expense)
        }
        
        for ele in ["food","groceries"] {
            let categ = Expense_Category(context: viewContext)
            categ.name = ele
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer
    
    private func DeleteDatabase(container: NSPersistentCloudKitContainer) {
        try! container.persistentStoreCoordinator.destroyPersistentStore(at: container.persistentStoreDescriptions.first!.url!, ofType: container.persistentStoreDescriptions.first!.type, options: container.persistentStoreDescriptions.first!.options)

    }

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "ExpenseTrackingTool")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
//        DeleteDatabase(container: container)
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
    }
}
