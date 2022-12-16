//
//  Expense.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 15.12.2022.
//

import Foundation

// MARK: Expense Model and Sample Data

struct Expense2: Identifiable, Hashable {
    var id = UUID().uuidString
    var remark: String
    var amount: Double
    var date: Date
    var type: ExpenseType
    var color: String
}

enum ExpenseType: String {
    case income = "Income"
    case expense = "Expenses"
    case all = "ALL"
}

var sample_expenses: [Expense2] = [
    Expense2(remark: "Magic Keyboard", amount: 99, date: Date(timeIntervalSince1970: 1669993191), type: .expense, color: "Yellow"),
    Expense2(remark: "Food", amount: 19, date: Date(timeIntervalSince1970: 1670079591), type: .expense, color: "Red"),
    Expense2(remark: "Magic Trackpad", amount: 99, date: Date(timeIntervalSince1970: 1670165991), type: .expense, color: "Purple"),
    Expense2(remark: "Uber Cab", amount: 20, date: Date(timeIntervalSince1970: 1670252391), type: .expense, color: "Green"),
    Expense2(remark: "Amazon Purchase", amount: 29, date: Date(timeIntervalSince1970: 1670338791), type: .expense, color: "Yellow"),
    Expense2(remark: "Stocks", amount: 1399, date: Date(timeIntervalSince1970: 1670425191), type: .income, color: "Purple"),
    Expense2(remark: "In App Purchase", amount: 499, date: Date(timeIntervalSince1970: 1670511591), type: .income, color: "Red"),
    Expense2(remark: "Movie Ticket", amount: 99, date: Date(timeIntervalSince1970: 1670597991), type: .expense, color: "Yellow"),
    Expense2(remark: "Apple Music", amount: 25, date: Date(timeIntervalSince1970: 1670684391), type: .expense, color: "Green"),
    Expense2(remark: "Snack", amount: 49, date: Date(timeIntervalSince1970: 1670770791), type: .expense, color: "Purple"),
]
