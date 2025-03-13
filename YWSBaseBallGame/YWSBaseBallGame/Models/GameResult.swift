//
//  GameResult.swift
//  YWSBaseBallGame
//
//  Created by 양원식 on 3/13/25.
//

import Foundation

// 게임 결과를 관리하는 구조체
struct GameResult {
    let strike: Int
    let ball: Int

    var isCorrect: Bool {
        return strike == 3
    }

    func display() {
        if isCorrect {
            print("정답입니다!")
            return
        }

        var result = [String]()
        if strike > 0 { result.append("\(strike) 스트라이크") }
        if ball > 0 { result.append("\(ball) 볼") }

        print(result.isEmpty ? "Nothing" : result.joined(separator: ", "))
    }

    static func calculateScore(_ userInput: [Int], _ correctAnswer: [Int]) -> GameResult {
        var strike = 0
        var ball = 0

        for (index, number) in userInput.enumerated() {
            if number == correctAnswer[index] {
                strike += 1
            } else if correctAnswer.contains(number) {
                ball += 1
            }
        }

        return GameResult(strike: strike, ball: ball)
    }
}
