//
//  CustomDialog.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 19.12.2022.
//

import SwiftUI

struct CustomDialog: View {
    // MARK: - Variables

    var title: String
    var message: String
    var yesDismiss: () -> Void

    // MARK: - View

    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text(title)
                    .font(.title)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                Text(message)
                    .font(.title3)
                    .foregroundColor(Color.black.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.top, .bottom], 20)
                GradientButton(text: title, clicked: {
                    yesDismiss()
                })

            }.padding(.top, 20)
        }
        .frame(width: 300, height: 300)
        .cornerRadius(20).shadow(radius: 20)
    }
}
