//
//  EditExpenseView.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 19.12.2022.
//

import SwiftUI

struct EditExpenseView: View {
    // MARK: Environment Values
    
    @EnvironmentObject var expenseVM: ExpenseViewModel
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var transaction: FetchedResults<Transaction>.Element
    
    // MARK: State Values

    @State private var showingAlert = false
    @State private var remark = ""
    @State private var amount = ""
    @State private var date: Date = .init()
    @State private var transactionType: TransactionType = .expense
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Edit Expenses")
                .font(.title2)
                .fontWeight(.semibold)
                .opacity(0.5)
                    
            // MARK: Custom Labels

            Group {
                Label {
                    TextField(transaction.remark!, text: $remark)
                        .padding(.leading, 10)
                        .onAppear {
                            remark = transaction.remark!
                            amount = "\(transaction.amount)"
                            date = transaction.date ?? Date()
                        }
                } icon: {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                        
                Label {
                    TextField("\(transaction.amount)", text: $amount)
                        .padding(.leading, 10)
                } icon: {
                    Image(systemName: "dollarsign")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                        
                CustomCheckboxes(isEditMode: true)
                        
                Label {
                    DatePicker("\(date)", selection: $date, in: Date.distantPast ... Date(), displayedComponents: [.date])
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .labelsHidden()
                } icon: {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                        
                // MARK: Save Button

                GradientButton(text: "Update") {
                    let amountInDouble = (amount as NSString).doubleValue
                            
                    DataController().editTransaction(transaction: transaction, remark: remark, amount: amountInDouble, date: date, type: transactionType, context: managedObjContext)

                    remark = ""
                    amount = ""
                    transactionType = TransactionType.all
                    
                    showingAlert = true
                }
                .disabled(remark == "" || transactionType == .all || amount == "")
                .opacity(remark == "" || transactionType == .all || amount == "" ? 0.6 : 1)
                .alert("Transaction has been updated", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {}
                }
            }
                   
            .padding(.horizontal, 5)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.white)
            }
            .padding(.top, 15)
            .padding(.bottom, 5)
            .padding([.leading, .trailing], 10)
        }
    }
}
