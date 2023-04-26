//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Тадевос Курдоглян on 24.04.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
