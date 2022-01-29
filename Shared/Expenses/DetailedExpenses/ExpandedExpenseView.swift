//
//  ExpandedExpenseView.swift
//  ExpenseTrackingMulti
//
//  Created by Jordan Elizaga on 1/28/22.
//

import SwiftUI

struct ExpandedExpenseView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch requests
    @FetchRequest( sortDescriptors: [NSSortDescriptor(keyPath: \Expense_Category.name, ascending: true)],  animation: .default) var categories: FetchedResults<Expense_Category>
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Expense_Detail.purpose, ascending: false)], predicate: NSPredicate(format: "ANY SELF.expense == %@", expense), animation: .default)
    @FetchRequest var expense_details : FetchedResults<Expense_Detail>
    // MARK: States
    @State var IsExpanded : Bool
    @State private var expenseCategory: Expense_Category = .init()
    @ObservedObject var expense: Expense
    
    private var isExpenseCategoryDisabled : Binding<Bool> { Binding (
        get: { self.IsExpanded },
        set: { _ in }
    )}
    
    init(expense: Expense) {
        self.expense = expense
        _expense_details = FetchRequest<Expense_Detail>(sortDescriptors: [NSSortDescriptor(keyPath: \Expense_Detail.purpose, ascending: false)], predicate: NSPredicate(format: "ANY SELF.expense == %@", expense), animation: .default)
        
        _IsExpanded = State(initialValue: !_expense_details.wrappedValue.isEmpty)

    }
    
    var body: some View {
        // Form {
        Section(header:Text("Details").font(.title2)) {
                ExpenseCategoryPicker(expenseCategory: expenseCategory)
            Toggle("Add details", isOn: $IsExpanded)
            
            if (IsExpanded) {
                List {
                    ForEach(expense_details, id: \.self) { detail in
                
                        HStack {
                            DetailedExpenseView(detail: detail)
                        }
                    }
                }
            }
        }
#if os(macOS)
        .collapsible(true)
#endif
        
    }
}

struct ExpandedExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedExpenseView(expense: Expense())
    }
}
