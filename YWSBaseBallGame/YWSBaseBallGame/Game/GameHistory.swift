//
//  GameHistory.swift
//  YWSBaseBallGame
//
//  Created by 양원식 on 3/13/25.
//

import Foundation

// 게임 기록을 관리하는 클래스
final class GameHistory {
    private var history: [(gameNumber: Int, attempts: Int)] = []

    func addRecord(gameNumber: Int, attempts: Int) {
        history.append((gameNumber, attempts))
    }

    func showGameHistory() {
        print("\n< 게임 기록 보기 >")
        if history.isEmpty {
            print("아직 게임 기록이 없습니다.")
        } else {
            for record in history {
                print("\(record.gameNumber)번째 게임 : 시도 횟수 - \(record.attempts)")
            }
        }
    }

    func clearHistory() {
        history.removeAll()
    }
}
