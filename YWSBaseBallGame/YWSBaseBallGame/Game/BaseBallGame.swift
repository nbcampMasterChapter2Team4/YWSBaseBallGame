//
//  baseBallGame.swift
//  YWSBaseBallGame
//
//  Created by 양원식 on 3/11/25.
//


//    - [✅]  1에서 9까지의 서로 다른 임의의 수 3개를 정하고 맞추는 게임입니다
//    - [✅]  정답은 랜덤으로 만듭니다.(1에서 9까지의 서로 다른 임의의 수 3자리)
//    - [✅]  정답을 맞추기 위해 3자리수를 입력하고 힌트를 받습니다
//        - [✅]  힌트는 야구용어인 **볼**과 **스트라이크**입니다.
//        - [✅]  같은 자리에 같은 숫자가 있는 경우 **스트라이크**, 다른 자리에 숫자가 있는 경우 **볼**입니다
//        - ex) 정답 : 456 인 경우
//            - 435를 입력한 경우 → 1스트라이크 1볼
//            - 357를 입력한 경우 → 1스트라이크
//            - 678를 입력한 경우 → 1볼
//            - 123를 입력한 경우 → Nothing
//        - 만약 올바르지 않은 입력값에 대해서는 오류 문구를 보여주세요
//    - 3자리 숫자가 정답과 같은 경우 게임이 종료됩니다
//    - [✅]  정답이 되는 숫자를 0에서 9까지의 서로 다른 3자리의 숫자로 바꿔주세요
//        - 맨 앞자리에 0이 오는 것은 불가능합니다
//            - 092 → 불가능
//            - 870 → 가능
//            - 300 → 불가능
//    - [✅] 프로그램을 시작할 때 안내문구를 보여주세요
//        - 1번 게임 시작하기의 경우 “필수 구현 기능” 의 예시처럼 게임이 진행됩니다
//            - 정답을 맞혀 게임이 종료된 경우 위 안내문구를 다시 보여주세요
//                - 예시
//                    환영합니다! 원하시는 번호를 입력해주세요
//                    1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
//                    1 // 1번 게임 시작하기 입력
//
//                    < 게임을 시작합니다 >
//                    숫자를 입력하세요
//    - [✅] 2번 게임 기록 보기의 경우 완료한 게임들에 대해 시도 횟수를 보여줍니다
//    - [✅] 3번 종료하기의 경우 프로그램이 종료됩니다
//        - 이전의 게임 기록들도 초기화됩니다
//    - [✅] 1, 2, 3 이외의 입력값에 대해서는 오류 메시지를 보여주세요
//
//
//
//

import Foundation

// 숫자 야구 게임 실행을 담당하는 클래스
final class BaseBallGame {
    private var gameHistory: GameHistory = GameHistory()
    private var gameCount = 0 // 게임 번호 추적

    // 프로그램 실행 (메뉴 표시)
    func run() {
        while true {
            showMenu()
            if let input = readLine(), let choice = Int(input), let menu = MenuOption(rawValue: choice) {
                switch menu {
                case .start:
                    start()
                case .history:
                    gameHistory.showGameHistory()
                case .description:
                    showGameDescription()
                case .exit:
                    print("\n< 숫자 야구 게임을 종료합니다 >")
                    gameHistory.clearHistory() // 게임 기록 초기화
                    return
                }
            } else {
                print("\n ⚠️ 올바른 숫자를 입력해주세요! (1 ~ 4) ⚠️\n")
            }
        }
    }

    // 메뉴 표시
    private func showMenu() {
        print("\n ⚾️ 환영합니다! 원하시는 번호를 입력해주세요 ⚾️")
        print("1. 게임 시작하기  2. 게임 기록 보기  3. 게임 설명  4. 종료하기")
    }

    // 게임 시작 메서드
    private func start() {
        print("\n< 게임을 시작합니다 >")
        let correctAnswer = NumberGenerator.makeAnswer()
        var attempts = 0 // 시도 횟수 카운트

        while true {
            let userInputAnswer = InputValidator.inputAnswer()
            attempts += 1 // 입력할 때마다 시도 횟수 증가
            
            if validateAnswer(userInputAnswer, correctAnswer) {
                print("게임을 종료합니다.")
                gameCount += 1
                gameHistory.addRecord(gameNumber: gameCount, attempts: attempts) // 게임 기록 저장
                break
            }
        }
    }

    // 정답과 사용자 입력 비교 (스트라이크 & 볼 판정)
    private func validateAnswer(_ userInput: [Int], _ correctAnswer: [Int]) -> Bool {
        let result = GameResult.calculateScore(userInput, correctAnswer)
        result.display()
        
        return result.isCorrect
    }
}
