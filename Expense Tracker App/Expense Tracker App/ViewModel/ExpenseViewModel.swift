//
//  ExpenseViewModel.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 15.12.2022.
//

import SwiftUI

class ExpenseViewModel: ObservableObject {
    // MARK: Properties

    @Published var startDate: Date = .init()
    @Published var endDate: Date = .init()
    @Published var currentMonthStartDate: Date = .init()



    // MARK: Expense / Income Tab

    @Published var tabName: ExpenseType = .expense

    // MARK: Filter View

    @Published var showFilterView: Bool = false

    // MARK: New Expense Properties

    @Published var addNewExpense: Bool = false
    @Published var amount: String = ""
    @Published var type: ExpenseType = .all
    @Published var date: Date = .init()
    @Published var remark: String = ""

    init() {
        // MARK: Fetching Current Month Starting Date

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())

        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
    }

    @Published var expenses: [Expense2] = sample_expenses

    // MARK: Fetching Current Month Date String

    func currentMonthDateString() -> String {
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }

    func convertExpensesToCurrency(expenses: [Expense2], type: ExpenseType = .all) -> String {
        var value: Double = 0

        value = expenses.reduce(0) { partialResult, expense in
            partialResult + (type == .all ? (expense.type == .income ? expense.amount : -expense.amount) : (expense.type == type ? expense.amount : 0))
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

    // MARK: Save Data

    func saveData(env: EnvironmentValues) {
        // MARK: Do Actions Here

        print("Save")
        let amountInDouble = (amount as NSString).doubleValue
        let colors = ["Yellow", "Red", "Purple", "Green"]
        let expense = Expense2(remark: remark, amount: amountInDouble, date: date, type: type, color: colors.randomElement() ?? "Yellow")
        withAnimation { expenses.append(expense) }
        expenses = expenses.sorted(by: { first, second in
            second.date < first.date
        })

        env.dismiss()
    }
}
