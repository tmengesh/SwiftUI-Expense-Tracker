//
//  ExpenseCard.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 15.12.2022.
//

import SwiftUI

struct ExpenseCard: View {
    @EnvironmentObject var expenseVM: ExpenseViewModel
    var isFilter: Bool = false
    var body: some View {
        GeometryReader { _ in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    .linearGradient(colors: [
                        Color("Gradient1"),
                        Color("Gradient2"),
                        Color("Gradient3"),
                    ], startPoint: .topLeading, endPoint: .bottomTrailing))

            VStack(spacing: 15) {
                VStack(spacing: 15) {
                    // MARK: Current Ongoing Month Date String

                    Text(isFilter ? expenseVM.convertDateToString() : expenseVM.currentMonthDateString())
                        .font(.callout)
                        .fontWeight(.semibold)

                    // MARK: Current Month Expenses Price

                    Text(expenseVM.convertExpensesToCurrency(expenses: expenseVM.expenses))
                        .font(.system(size: 35, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom, 5)
                }
                .offset(y: -10)

                HStack(spacing: 15) {
                    Image(systemName: "arrow.down")
                        .font(.caption.bold())
                        .foregroundColor(Color("Green"))
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7), in: Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Income")
                            .font(.caption)
                            .opacity(0.7)

                        Text(expenseVM.convertExpensesToCurrency(expenses: expenseVM.expenses, type: .income))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "arrow.up")
                        .font(.caption.bold())
                        .foregroundColor(Color("Red"))
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7), in: Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Expenses")
                            .font(.caption)
                            .opacity(0.7)

                        Text(expenseVM.convertExpensesToCurrency(expenses: expenseVM.expenses, type: .expense))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
                .offset(y: 15)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 220)
        .padding(.top)
    }
}
