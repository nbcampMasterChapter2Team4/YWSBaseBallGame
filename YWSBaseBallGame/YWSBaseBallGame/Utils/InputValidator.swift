//
//  InputValidator.swift
//  YWSBaseBallGame
//
//  Created by 양원식 on 3/13/25.
//

import Foundation

// 사용자 입력 검증 유틸리티
struct InputValidator {
    static func inputAnswer() -> [Int] {
        while true {
            print("숫자를 입력하세요.")

            if let input = readLine(), let answer = validateInput(input) {
                return answer
            }
        }
    }

    private static func validateInput(_ input: String) -> [Int]? {
        guard input.allSatisfy({ $0.isNumber }) else {
            print("⚠️ 숫자가 아닌 문자가 포함되어 있습니다. 다시 입력해주세요. ⚠️\n")
            return nil
        }

        let inputAnswer = input.compactMap { $0.wholeNumberValue }

        guard inputAnswer.count == 3 else {
            print("⚠️ 3개의 숫자만 입력 가능합니다. ⚠️\n")
            return nil
        }

        guard Set(inputAnswer).count == inputAnswer.count else {
            print("⚠️ 숫자는 각각 한 개씩만 사용할 수 있습니다. ⚠️\n")
            return nil
        }

        guard inputAnswer.first != 0 else {
            print("⚠️ 첫 번째 숫자는 0이 될 수 없습니다. ⚠️\n")
            return nil
        }

        return inputAnswer
    }
}
