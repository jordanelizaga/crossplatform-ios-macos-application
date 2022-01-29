//
//  ExpenseNavigationView.swift
//  ExpenseTrackingTool
//
//  Created by Jordan Elizaga on 1/28/22.
//

import SwiftUI

struct ExpensesNavigationLink: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date_transaction, ascending: true)],
        animation: .default)
    private var expenses: FetchedResults<Expense>
    private let expenseFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()

    private let navigationDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    private func addExpense() {
        withAnimation {
            newExpense = Expense(context: viewContext)
            let d = Date()
            newExpense.date_created = d
            newExpense.date_transaction = d
            newExpense.purpose = ""
            try? viewContext.save()
        }
        self.isNewExpenseView = true

    }

        
    private func deleteexpenses(offsets: IndexSet) {
        withAnimation {
            offsets.map { expenses[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    // MARK: States
    @State var isNewExpenseView : Bool
    @State var newExpense : Expense = Expense()
    @State var toolbarDate : Date = Date()
//    @ObservedObject var selectedExpense : Expense
    @State var selectedExpense : Expense? = nil
    @State  var isDeleteSelection = false
    // MARK: Body
    var body: some View {
        List {
            ForEach(expenses, id: \.objectID) { expense in
                NavigationLink(tag: expense,
                               selection: $selectedExpense,
                    destination: {
                    ExpenseView(expense: expense)
                    #if os(macOS)
                        .padding()
                    #endif
                    Text("expense at \(expense.date_created!, formatter: expenseFormatter)")
                }, label: {
                    Text("\(expense.date_transaction, formatter: navigationDateFormatter) - \(expense.purpose)")
                })
                    .contextMenu( ) {
                        Button (action: {
                            self.isDeleteSelection = true
                            viewContext.delete(expense)
                            viewContext.genericDebugSave()
                        }, label: {
                            Label("Delete", systemImage: "minus")
                        })
                            .keyboardShortcut(.deleteForward, modifiers: [])
                            .keyboardShortcut(.delete, modifiers: [])
                    }

            }
            .onDelete(perform: deleteexpenses)
        }
        .navigationTitle("Expenses")
        .toolbar {
            ToolbarItem {
                Button(action: addExpense) {
                    Label("Add expense", systemImage: "plus")
                }
            }
            ToolbarItem {

//                DatePicker("Month", selection: $toolbarDate, displayedComponents: [.date])
//                    .datePickerStyle(GraphicalDatePickerStyle())
            }
        }
        .popover(isPresented: $isNewExpenseView) {

//        .sheet(isPresented: $isNewExpenseView, onDismiss: viewContext.genericDebugSave) {
            ExpenseView(expense: newExpense).padding()
        }
    }
}

struct ExpenseNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesNavigationLink(isNewExpenseView: false)
    }
}
