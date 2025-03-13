//
//  NumberGenerator.swift
//  YWSBaseBallGame
//
//  Created by 양원식 on 3/13/25.
//

import Foundation

// 랜덤 숫자 생성 유틸리티
struct NumberGenerator {
    static func makeAnswer() -> [Int] {
        var numbers = (0...9).shuffled()
        
        if numbers[0] == 0 {
            if let nonZeroIndex = numbers.firstIndex(where: { $0 != 0 }) {
                numbers.swapAt(0, nonZeroIndex)
            }
        }
        
        return Array(numbers.prefix(3))
    }
}
