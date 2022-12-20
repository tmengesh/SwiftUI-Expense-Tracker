//
//  Logger.swift
//  Expense Tracker App
//
//  Created by Tewodros Mengesha on 20.12.2022.
//

import Foundation
import os

extension Logger {
    static func createLogger(file: String = #file) -> Logger {
        let fileString = NSString(string: file)
        return Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Expense Tracker App-\(fileString.lastPathComponent.split(separator: ".").first!)")
    }

    func pretty_function(function: String = #function, line: Int = #line) {
        self.debug("\(function)")
    }
}
