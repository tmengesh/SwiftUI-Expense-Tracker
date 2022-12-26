//
//  AuthenticationView.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 26.12.2022.
//

import LocalAuthentication
import os
import SwiftUI

struct AuthenticationView: View {
    @State private var isAuthenticated = false
    @Binding var isUnlocked: Bool

    private let logger = Logger.createLogger()

    var body: some View {
        VStack {}
            .onAppear(perform: self.authenticate)
    }

    func authenticate() {
        logger.pretty_function()
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to unlock the app"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                        self.isUnlocked = true
                        logger.info("Sucessfully authenticated")
                    } else {
                        // Show an error message

                        logger.error("Authentication failed")
                    }
                }
            }
        } else {
            logger.error("Device does not support biometric authentication")
            if !isAuthenticated {
                CustomDialog(title: "Error", message: "Device does not support biometric authentication", buttonTitle: "Dismiss", isError: true)
            }
        }
    }
}
