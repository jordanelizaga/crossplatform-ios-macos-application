//
//  ExpenseCategoryPicker.swift
//  ExpenseTrackingMulti
//
//  Created by Jordan Elizaga on 1/28/22.
//

import SwiftUI

struct ExpenseCategoryPicker: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest( sortDescriptors: [NSSortDescriptor(keyPath: \Expense_Category.name, ascending: true)],  animation: .default) var categories: FetchedResults<Expense_Category>

    @ObservedObject var expenseCategory : Expense_Category
    init(expenseCategory: Expense_Category) {
        self.expenseCategory = expenseCategory
    }
    var body: some View {
        Picker("Select category", selection: $expenseCategory.name) {
            ForEach(categories) { category in
                Text(category.name ?? "Name not found").tag(category.name)
            }
        }
    }
}

struct ExpenseCategoryPicker_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseCategoryPicker(expenseCategory: Expense_Category())
    }
}
