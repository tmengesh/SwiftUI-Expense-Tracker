//
//  DataController.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 16.12.2022.
//

import CoreData
import Foundation
import SwiftUI

class DataController: ObservableObject {
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "TransactionModel")

    init() {
        container.loadPersistentStores { [self] _, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }

    // MARK: Save Context To Core Data

    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    // MARK: Add Transaction

    func addTransaction(remark: String, amount: Double, date: Date, color: String, type: TransactionType, context: NSManagedObjectContext) {
        let transaction = Transaction(context: context)
        transaction.id = UUID()
        transaction.remark = remark
        transaction.amount = amount
        transaction.date = date
        transaction.color = color
        transaction.expenseType = type.rawValue

        save(context: context)
    }

    // MARK: Edit Transaction

    func editTransaction(transaction: Transaction, remark: String, amount: Double, date: Date, type: TransactionType, context: NSManagedObjectContext) {
        transaction.remark = remark
        transaction.amount = amount
        transaction.date = date
        transaction.expenseType = type.rawValue

        save(context: context)
    }
}
