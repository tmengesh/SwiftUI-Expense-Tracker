//
//  ExpenseViewModel.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 15.12.2022.
//

import CoreData
import SwiftUI

class ExpenseViewModel: ObservableObject {
    // MARK: Properties

    @Published var startDate: Date = .init()
    @Published var endDate: Date = .init()
    @Published var currentMonthStartDate: Date = .init()

    // MARK: Expense / Income Tab

    @Published var tabName: TransactionType = .expense

    // MARK: Filter View

    @Published var showFilterView: Bool = false

    // MARK: New Expense Properties

    @Published var addNewExpense: Bool = false
    @Published var editExpense: Bool = false
    @Published var amount: String = ""
    @Published var type: TransactionType = .all
    @Published var date: Date = .init()
    @Published var remark: String = ""

    init() {
        // MARK: Fetching Current Month Starting Date

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())

        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
    }

    // MARK: Fetching Current Month Date String

    func currentMonthDateString() -> String {
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }

    // MARK: Converting ConvertedTransaction to Currency String

    func convertTransactionToCurrency(transactions: FetchedResults<Transaction>, type: TransactionType = .all) -> String {
        var value: Double = 0

        value = transactions.reduce(0) { partialResult, transaction in
            var value: Double {
                if transaction.expenseType == TransactionType.income.rawValue {
                    return transaction.amount
                } else {
                    return -transaction.amount
                }
            }

            var value2: Double {
                if transaction.expenseType == type.rawValue {
                    return transaction.amount
                } else {
                    return 0
                }
            }

            return partialResult + (type == .all ? value : value2)
        }

        return convertNumberToPrice(value: value)
    }

    // MARK: Converting Selected Dates To String

    func convertDateToString() -> String {
        return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }

    // MARK: Converting Number To Price

    func convertNumberToPrice(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        return formatter.string(from: .init(value: value)) ?? "$0.00"
    }

    // MARK: Clearning All Data

    func clearData() {
        date = Date()
        type = .all
        remark = ""
        amount = ""
    }
}
