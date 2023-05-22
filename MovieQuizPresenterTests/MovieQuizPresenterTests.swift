//
//  MovieQuizPresenterTests.swift
//  MovieQuizPresenterTests
//
//  Created by Тадевос Курдоглян on 22.05.2023.
//


import XCTest
@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    func show(allertModel: MovieQuiz.AlertModel) {
        
    }
    
    func enableButtons(_: Bool) {
    }
    
    func hideImageBorder() {
        
    }
    
    func showImageBorder(isCorrect: Bool) {
        
    }
    
    func show(quiz step: QuizStepViewModel) {
    
    }
    
    func showLoadingIndicator() {
    
    }
    
    func hideLoadingIndicator() {
    
    }
    
    func showNetworkError(message: String) {
    
    }
}

final class MovieQuizPresenterTests: XCTestCase {
    func testPresenterConvertModel() throws {
        let viewControllerMock = MovieQuizViewControllerMock()
        let sut = MovieQuizPresenter(viewController: viewControllerMock)
        
        let emptyData = Data()
        let question = QuizQuestion(image: emptyData, text: "Question Text", correctAnswer: true)
        let viewModel = sut.convert(model: question)
        
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.question, "Question Text")
        XCTAssertEqual(viewModel.questionNumber, "1/10")
    }
}
