//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Тадевос Курдоглян on 24.04.2023.
//

import Foundation
import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let accessibilityIdentifier: String
    
    var compition: ((UIAlertAction) -> Void)
    
    init(title: String, message: String, buttonText: String, compition: @escaping (UIAlertAction) -> Void) {
        self.title = title
        self.message = message
        self.buttonText = buttonText
        self.accessibilityIdentifier = ""
        self.compition = compition
    }
    
    init(title: String, message: String, buttonText: String, accessibilityIdentifier: String, compition: @escaping (UIAlertAction) -> Void) {
        self.title = title
        self.message = message
        self.buttonText = buttonText
        self.accessibilityIdentifier = accessibilityIdentifier
        self.compition = compition
    }
}
