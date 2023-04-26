//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Тадевос Курдоглян on 26.04.2023.
//

import Foundation

protocol StatisticService {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get set }
    var bestGame: GameRecord { get }
    func store(correct count: Int, total amount: Int)
    func getMessage() -> String
}

final class StatisticServiceImplementation: StatisticService {
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    var totalAccuracy: Double {
        get {
            Double(userDefaults.integer(forKey: Keys.correct.rawValue)) / Double(userDefaults.integer(forKey: Keys.total.rawValue))
        }
    }

    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }

        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
     
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            return record
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    var correct: Int {
        userDefaults.integer(forKey: Keys.correct.rawValue)
    }

    var total: Int {
         userDefaults.integer(forKey: Keys.total.rawValue)
    }
    
    func store(correct count: Int, total amount: Int) {
        let newResult = GameRecord(correct: count, total: amount, date: Date())
        if newResult > bestGame {
            bestGame = newResult
        }

        let newCorrect = newResult.correct + correct
        userDefaults.set(newCorrect, forKey: Keys.correct.rawValue)

        let newTotal = newResult.total + total
        userDefaults.set(newTotal, forKey: Keys.total.rawValue)

        gamesCount += 1
    }
    
    func getMessage() -> String {
        let message = """
              Количество сыгранных квизов: \(gamesCount)
              Рекорд: \(bestGame.correct)/10 (\(bestGame.date.dateTimeString))
              Средняя точность: \(String(format: "%.2f", totalAccuracy * 100))%
        """
        return message
    }
}
