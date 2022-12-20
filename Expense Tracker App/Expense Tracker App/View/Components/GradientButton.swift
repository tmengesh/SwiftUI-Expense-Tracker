//
//  GradientButton.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 19.12.2022.
//

import SwiftUI

struct GradientButton: View {
    var text: String
    var clicked: () -> Void

    var body: some View {
        Button(action: clicked) {
            HStack {
                Text(text)
            }
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(
                        LinearGradient(colors: [
                            Color("Gradient1"),
                            Color("Gradient2"),
                            Color("Gradient3"),
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
            }
            .foregroundColor(.white)
            .padding(.bottom, 10)
        }
    }
}
