//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Тадевос Курдоглян on 22.05.2023.
//

import Foundation
import UIKit

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(allertModel: AlertModel)
    
    func hideImageBorder()
    func showImageBorder(isCorrect: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
    
    func enableButtons(_ :Bool)
}
