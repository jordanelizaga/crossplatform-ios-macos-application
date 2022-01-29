//
//  DecimalTextField.swift
//  ExpenseTrackingMulti
//
//  Created by Jordan Elizaga on 1/28/22.
//

import SwiftUI

struct DecimalCostTextField: View {
    
    private let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true
        return formatter
    }()
    
    @ObservedObject var value : Expense
    private var title : String = ""
    init(title: String, value: Expense ) {
        self.title = title
        self.value = value
    }
    
    var body: some View {
        TextField(self.title, value: self.$value.cost, formatter: decimalFormatter )
    }
}

struct DecimalTextField_Previews: PreviewProvider {
    static var previews: some View {
        DecimalCostTextField(title: "", value: Expense())
    }
}
