//
//  FilteredDetailView.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 15.12.2022.
//

import SwiftUI

struct FilteredDetailView: View {
    @EnvironmentObject var expenseVM: ExpenseViewModel

    // MARK: Environment Values

    @Environment(\.self) var env
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    // MARK: Back Button

                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                    Text("Transactions")
                        .font(.title.bold())
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Button {
                        expenseVM.showFilterView = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }

                // MARK: Expense Card View For Currently Selected Date

                ExpenseCard(isFilter: true)
                    .environmentObject(expenseVM)

                CustomSegmentedControl()
                    .padding(.top)

                // MARK: Currently Filtered Date With Amount

                VStack(spacing: 15) {
                    Text(expenseVM.convertDateToString())
                        .opacity(0.7)

                    Text(expenseVM.convertExpensesToCurrency(expenses: expenseVM.expenses, type: expenseVM.tabName))
                        .font(.title.bold())
                        .opacity(0.9)
                        .animation(.none, value: expenseVM.tabName)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
                .padding(.vertical, 20)

                ForEach(expenseVM.expenses.filter {
                    $0.type == expenseVM.tabName
                }) { expense in
                    TransactionCardView(expense: expense)
                        .environmentObject(expenseVM)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .background {
            Color("Background")
                .ignoresSafeArea()
        }
        .overlay {
            FilterView()
        }
    }

    // MARK: Filter View

    func FilterView() -> some View {
        ZStack {
            Color.black
                .opacity(expenseVM.showFilterView ? 0.25 : 0)
                .ignoresSafeArea()
            
            //MARK: Based On the Date Filter Expense Array

            if expenseVM.showFilterView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Start Date")
                        .font(.caption)
                        .opacity(0.7)

                    DatePicker("", selection:
                        $expenseVM.startDate, in: Date.distantPast ... Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)

                    Text("End Date")
                        .font(.caption)
                        .opacity(0.7)
                        .padding(.top, 10)

                    DatePicker("", selection:
                        $expenseVM.endDate, in: Date.distantPast ... Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                }
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }

                // MARK: Close Button

                .overlay(alignment: .topTrailing, content: {
                    Button {
                        expenseVM.showFilterView = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding(5)
                    }
                })
                .padding()
            }
        }
        .animation(.easeInOut, value: expenseVM.showFilterView)
    }

    // MARK: Custom Segmented Control

    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach([ExpenseType.income, ExpenseType.expense], id: \.rawValue) { tab in
                Text(tab.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(expenseVM.tabName == tab ? .white : .black)
                    .opacity(expenseVM.tabName == tab ? 1 : 0.7)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background {
                        // MARK: With Matched Geometry Effect

                        if expenseVM.tabName == tab {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                    LinearGradient(colors: [
                                        Color("Gradient1"),
                                        Color("Gradient2"),
                                        Color("Gradient3"),
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation { expenseVM.tabName = tab }
                    }
            }
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
    }
}

struct FilteredDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredDetailView()
            .environmentObject(ExpenseViewModel())
    }
}
