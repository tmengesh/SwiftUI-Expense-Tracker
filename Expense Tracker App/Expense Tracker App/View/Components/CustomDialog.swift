//
//  CustomDialog.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 26.12.2022.
//

import SwiftUI

struct CustomDialog: View {
    var title: String
    var message: String
    var buttonTitle: String
    var isError: Bool = false
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        VStack {
            Text("\(Image(systemName: isError ? "person.crop.circle.badge.exclamationmark" : "info.circle")) \(title)")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding()
            Text(message)
                .font(.body)
                .foregroundColor(.primary)
                .padding()

            GradientButton(text: buttonTitle, clicked: {
                self.presentationMode.wrappedValue.dismiss()
            }).opacity(0.75)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}
