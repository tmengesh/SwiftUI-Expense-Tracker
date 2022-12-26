//
//  NewExpenseView.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 16.12.2022.
//

import SwiftUI

struct NewExpenseView: View {
    // MARK: Environment Values

    @EnvironmentObject var expenseVM: ExpenseViewModel
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.self) var env

    @State private var showingAlert = false

    var body: some View {
        VStack {
            VStack(spacing: 15) {
                Text("Add Expenses")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(0.5)

                // MARK: Custom TextField

                // For Currency Sysmbol
                if let symbol = expenseVM.convertNumberToPrice(value: 0).first {
                    TextField("0", text: $expenseVM.amount)
                        .font(.system(size: 35))
                        .foregroundColor(Color("Gradient2"))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background {
                            Text(expenseVM.amount == "" ? "0" : expenseVM.amount)
                                .font(.system(size: 35))
                                .opacity(0)
                                .overlay(alignment: .leading) {
                                    Text(String(symbol))
                                        .opacity(0.5)
                                        .offset(x: -15, y: 5)
                                }
                        }
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background {
                            Capsule()
                                .fill(.white)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top)
                }

                // MARK: Custom Labels

                Label {
                    TextField("Remark", text: $expenseVM.remark)
                        .padding(.leading, 10)
                } icon: {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 25)

                Label {
                    // MARK: CheckBoxes

                    CustomCheckboxes()
                } icon: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 25)

                Label {
                    DatePicker("", selection: $expenseVM.date, in: Date.distantPast ... Date(), displayedComponents: [.date])
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .labelsHidden()
                } icon: {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 5)
            }
            .frame(maxHeight: .infinity, alignment: .center)

            // MARK: Custom Alert View

            if showingAlert {
                CustomDialog(title: "Sucess", message: "New transaction has been added to the database", buttonTitle: "Ok")
                    .transition(.move(edge: .top))
                    .animation(.easeInOut, value: showingAlert)
            }

            // MARK: Save Button

            GradientButton(text: "Save") {
                let amountInDouble = (expenseVM.amount as NSString).doubleValue
                let colors = ["Yellow", "Red", "Purple", "Green"]

                DataController().addTransaction(remark: expenseVM.remark, amount: amountInDouble, date: expenseVM.date, color: colors.randomElement() ?? "Yellow", type: expenseVM.type, context: managedObjContext)

                expenseVM.clearData()

                showingAlert = true
            }

            .disabled(expenseVM.remark == "" || expenseVM.type == .all || expenseVM.amount == "")
            .opacity(expenseVM.remark == "" || expenseVM.type == .all || expenseVM.amount == "" ? 0.6 : 1)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color("Background")
                .ignoresSafeArea()
        }
        .overlay(alignment: .topTrailing) {
            // MARK: Close Button

            Button {
                env.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
                    .opacity(0.7)
            }
            .padding()
        }
    }
}

struct NewExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        NewExpenseView()
            .environmentObject(ExpenseViewModel())
    }
}
