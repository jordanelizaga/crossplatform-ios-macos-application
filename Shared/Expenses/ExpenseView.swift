//
//  ExpenseView.swift
//  ExpenseTrackingTool
//
//  Created by Jordan Elizaga on 1/27/22.
//

import SwiftUI
import CoreData

struct ExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var expense: Expense
    @State var someDate : Date = Date ()
    @State var somePurpose : String = ""
    
    init(expense: Expense? = nil) {
        if let exp = expense {
            self.expense = exp
            return
        }
        
        self.expense = Expense()
    }
    
    private let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true
        return formatter
    }()
    
    var body : some View {
        Section(header: Text("Expense Details").font(.largeTitle), footer: Text("Add specific details inclu. tips below").font(.caption)) {

            Form {
                // (1)
                
                TextField("Purpose of transaction", text:expense.isFault ? $somePurpose : $expense.purpose)
                    .onDisappear(perform: viewContext.genericDebugSave)
                DatePicker(selection: expense.isFault ? $someDate : $expense.date_transaction, in: ...Date(), displayedComponents: [.date], label: {
                    Text("Date of transaction")
                })
                    .onDisappear(perform: viewContext.genericDebugSave)
                DecimalCostTextField(title: "cost of expense: $34.10", value: expense)
                
                
                ExpandedExpenseView(expense: expense)
                
            }
            
#if os(macOS)
            .padding()
#endif
        }.toolbar() {
        }
        
    }
    
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView(expense: Expense()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
