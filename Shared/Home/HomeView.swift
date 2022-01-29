//
//  HomeView.swift
//  ExpenseTrackingMulti
//
//  Created by Jordan Elizaga on 1/28/22.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            List {
                NavigationLink() {
                    #if os(macOS)
                    NavigationView {
                        ExpensesNavigationLink(isNewExpenseView: false)
                    }
                    #else
                    ExpensesNavigationLink(isNewExpenseView: false)

                    #endif
                } label: {
                    Image(systemName: "dollarsign.circle")
                    Text("Expenses")
                }
                
                    NavigationLink() {
                        
                    } label: {
//                        Image(systemName: "dollarsign.circle")
                        Text("Account")
                    }
                
            }
            .navigationTitle("Expense Tracking Homepage")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
