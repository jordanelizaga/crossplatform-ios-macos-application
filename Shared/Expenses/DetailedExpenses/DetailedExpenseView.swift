//
//  DetailedExpenseView.swift
//  ExpenseTrackingMulti
//
//  Created by Jordan Elizaga on 1/28/22.
//

import SwiftUI

struct DetailedExpenseView: View {
    @ObservedObject var detail : Expense_Detail
    init(detail: Expense_Detail) {
        self.detail = detail
    }
    var body: some View {
        TextField("Expense details", text: $detail.purpose)
        ExpenseCategoryPicker(expenseCategory: detail.category)
        DecimalCostTextField(title: "Expense: $10.14", value: detail.expense)
    }
}

struct DetailedExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedExpenseView(detail: Expense_Detail())
    }
}
