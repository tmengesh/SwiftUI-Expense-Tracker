//
//  HomeView.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 15.12.2022.
//

import os
import SwiftUI

struct HomeView: View {
    @StateObject var expenseVM: ExpenseViewModel = .init()

    // MARK: Core Data Fetch

    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var transaction: FetchedResults<Transaction>

    // MARK: Displaying Price

    // var transaction: FetchedResults<Transaction>

    private let logger = Logger.createLogger()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Text("Tewodros M.")
                            .font(.title2.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink {
                        FilteredDetailView()
                            .environmentObject(expenseVM)
                    } label: {
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.gray)
                            .overlay(content: {
                                Circle()
                                    .stroke(.white, lineWidth: 2)
                                    .padding(7)
                            })
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }
                ExpenseCard(transaction: transaction)
                    .environmentObject(expenseVM)
                TransactionView()
                    .environmentObject(expenseVM)
            }
            .padding()
        }
        .background {
            Color("Background")
                .ignoresSafeArea()
        }
        .overlay(alignment: .bottomTrailing) {
            AddButton()
        }
        .fullScreenCover(isPresented: $expenseVM.addNewExpense) {
            expenseVM.clearData()
        } content: {
            NewExpenseView()
                .environmentObject(expenseVM)
        }
    }

    // MARK: Add New Expense Button

    @ViewBuilder
    func AddButton() -> some View {
        Button {
            expenseVM.addNewExpense.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background {
                    Circle()
                        .fill(
                            .linearGradient(colors: [
                                Color("Gradient1"),
                                Color("Gradient2"),
                                Color("Gradient3"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
        .padding()
    }

    // MARK: Transactions View

    @ViewBuilder
    func TransactionView() -> some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(transaction) { transaction in
                        NavigationLink(destination: EditExpenseView(transaction: transaction)) {
                            TransactionCardView(transaction: transaction)
                        }
                    }.onDelete(perform: deleteTransaction)
                }
                .listStyle(.plain)
                .navigationTitle("Transactions")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                .onAppear {
                    print("I am loaded")
                    // managedObjContext.reset()
                }
            }
        }
    }

    private func deleteTransaction(offsets: IndexSet) {
        logger.pretty_function()
        withAnimation {
            offsets.map { transaction[$0] }
                .forEach(managedObjContext.delete)

            // Saves to our database
            DataController().save(context: managedObjContext)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
