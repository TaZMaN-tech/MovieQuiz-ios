//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Тадевос Курдоглян on 24.04.2023.
//

import Foundation
import UIKit

class AlertPresenter: UIViewController, AlertPresenterProtocol {
    func show(allertModel: AlertModel) -> UIAlertController {
        let alert = UIAlertController(title: allertModel.title,
                                      message: allertModel.message,
                                      preferredStyle: .alert)

        let action = UIAlertAction(title: allertModel.buttonText, style: .default, handler: allertModel.compition)

        alert.addAction(action)

        return alert
    }
}
