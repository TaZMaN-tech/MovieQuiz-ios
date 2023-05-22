//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Тадевос Курдоглян on 19.05.2023.
//

import UIKit

final class MovieQuizPresenter: QuestionFactoryDelegate {
    
    private let questionsAmount: Int = 10
    private var currentQuestionIndex: Int = 0
    private var correctAnswers = 0
    
    var currentQuestion: QuizQuestion?
    private weak var viewController: MovieQuizViewControllerProtocol?
    private var questionFactory: QuestionFactoryProtocol?
    private var statisticService: StatisticService?
    
    init(viewController: MovieQuizViewControllerProtocol) {
            self.viewController = viewController
            
            questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
            questionFactory?.loadData()
            statisticService = StatisticServiceImplementation()
            viewController.showLoadingIndicator()
        }
    
    // MARK: - QuestionFactoryDelegate
    
    func didRecieveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    
    func didLoadDataFromServer() {
        viewController?.hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: Error) {
        viewController?.showNetworkError(message: error.localizedDescription)
    }
    
    func isLastQuestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    func restartGame() {
        currentQuestionIndex = 0
        correctAnswers = 0
        questionFactory?.requestNextQuestion()
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    private func didAnswer(isCorrectAnswer: Bool) {
        if isCorrectAnswer {
            correctAnswers += 1
        }
    }
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
    func yesButtonClicked() {
        didAnswer(isYes: true)
        
    }
    
    func noButtonClicked() {
        didAnswer(isYes: false)
    }
    
    private func didAnswer(isYes: Bool) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        
        let givenAnswer = isYes
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    func showNextQuestionOrResults() {
        if self.isLastQuestion() {
            statisticService?.gamesCount += 1
            statisticService?.store(correct: correctAnswers, total: self.questionsAmount)
            
            guard let recordMessage = statisticService?.getMessage() else {
                return
            }
            
            
            let alertModel = AlertModel(title: "Этот раунд окончен!",
                                        message: "Ваш результат: \(correctAnswers)/10\n\(recordMessage)",
                                        buttonText: "Сыграть ещё раз",
                                        accessibilityIdentifier: "Game results",
                                        compition: { [weak self] _ in
                guard let self = self else { return }
                
                self.restartGame()
                self.correctAnswers = 0
                
                questionFactory?.requestNextQuestion()
                viewController?.hideImageBorder()
            })
            
            viewController?.show(allertModel: alertModel)
            
        } else {
            self.switchToNextQuestion()
            viewController?.hideImageBorder()
            
            questionFactory?.requestNextQuestion()
        }
    }
    
    
    
    func reloadData() {
        questionFactory?.loadData()
    }
    
    func showAnswerResult(isCorrect: Bool) {
        self.didAnswer(isCorrectAnswer: isCorrect)
        
        viewController?.showImageBorder(isCorrect: isCorrect)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.showNextQuestionOrResults()
            viewController?.enableButtons(true)
        }
    }
} 
