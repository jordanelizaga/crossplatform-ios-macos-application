//
//  ExpenseTrackingMultiApp.swift
//  Shared
//
//  Created by Jordan Elizaga on 1/27/22.
//

import SwiftUI

@main
struct ExpenseTrackingMultiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView().environment(\.managedObjectContext, persistenceController.container.viewContext)
//            ExpensesNavigationView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
