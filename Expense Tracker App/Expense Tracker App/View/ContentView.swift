//
//  ContentView.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 15.12.2022.
//

import SwiftUI

struct ContentView: View {
    // NOTE: Change isUnlocekd to false if faceID and passcode needed to be used
    @State private var isUnlocked = true
    var body: some View {
        VStack {
            NavigationView {
                if isUnlocked {
                    HomeView()
                        .navigationBarHidden(true)
                } else {
                    AuthenticationView(isUnlocked: $isUnlocked)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
