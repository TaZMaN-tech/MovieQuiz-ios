//
//  AlertPresenterProtocol.swift
//  MovieQuiz
//
//  Created by Тадевос Курдоглян on 24.04.2023.
//

import Foundation
import UIKit

protocol AlertPresenterProtocol {
    func show(allertModel: AlertModel) -> UIAlertController 
}
