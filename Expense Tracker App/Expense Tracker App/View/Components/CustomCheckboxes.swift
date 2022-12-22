//
//  CustomCheckboxes.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 19.12.2022.
//

import SwiftUI

// MARK: Custom Checkboxes

struct CustomCheckboxes: View {
    @EnvironmentObject var expenseVM: ExpenseViewModel

    var body: some View {
        HStack(spacing: 10) {
            ForEach([TransactionType.income, TransactionType.expense], id: \.self) { type in
                ZStack {
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black, lineWidth: 2)
                        .opacity(0.5)
                        .frame(width: 20, height: 20)

                    if expenseVM.type == type {
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(Color("Green"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    expenseVM.type = type
                }

                Text(type.rawValue.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(0.7)
                    .padding(.trailing, 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 10)
    }
}
