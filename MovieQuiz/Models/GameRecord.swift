//
//  File.swift
//  MovieQuiz
//
//  Created by Тадевос Курдоглян on 26.04.2023.
//

import Foundation

struct GameRecord: Codable, Comparable {
    let correct: Int
    let total: Int
    let date: Date
    
    static func < (lhs: GameRecord, rhs: GameRecord) -> Bool {
        lhs.correct < rhs.correct
    }

    static func == (lhs: GameRecord, rhs: GameRecord) -> Bool {
        lhs.correct == rhs.correct
    }
}
