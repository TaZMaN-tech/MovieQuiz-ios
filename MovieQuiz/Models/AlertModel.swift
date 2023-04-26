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
    
    var compition: ((UIAlertAction) -> Void)
}
