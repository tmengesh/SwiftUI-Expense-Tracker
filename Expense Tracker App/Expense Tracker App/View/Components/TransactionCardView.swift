//
//  TransactionCardView.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 15.12.2022.
//

import os
import SwiftUI

struct TransactionCardView: View {
    // MARK: Variables

    @ObservedObject var transaction: Transaction
    @EnvironmentObject var expenseVM: ExpenseViewModel

    private let logger = Logger.createLogger()

    var body: some View {
        HStack(spacing: 12) {
            // MARK: First Letter Avatar

            if let first = transaction.remark?.first {
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background {
                        Circle()
                            .fill(Color(transaction.color!))
                    }
            }

            // MARK: Displaying Remark

            Text(transaction.remark ?? "")
                .fontWeight(.semibold)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .trailing, spacing: 7) {
                // MARK: Displaying Price

                let price = convertNumberToPrice(value: transaction.expenseType == TransactionType.expense.rawValue ? -transaction.amount : transaction.amount)

                Text(price)
                    .font(.callout)
                    .opacity(0.7)
                    .foregroundColor(transaction.expenseType == TransactionType.expense.rawValue
                        ? Color("Red") : Color("Green"))
                Text(transaction.date?.formatted(date: .numeric, time: .omitted) ?? "")
                    .font(.caption)
                    .opacity(0.5)
            }
        }

        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
        }
    }

    private func convertNumberToPrice(value: Double) -> String {
        logger.pretty_function()
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        return formatter.string(from: .init(value: value)) ?? "$0.00"
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
