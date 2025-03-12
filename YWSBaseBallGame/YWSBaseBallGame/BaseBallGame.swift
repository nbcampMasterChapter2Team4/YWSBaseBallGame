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

class BaseBallGame {
    
    // 게임 시작 메서드 (게임 흐름을 관리)
    func start() {
        gameIntroMessage() // 게임 시작 메시지 출력
        let correctAnswer = makeAnswer() // 랜덤 정답 생성
        while true {
            let userInputAnswer = inputAnswer() // 사용자 입력 받기
            
            // 사용자의 입력과 정답을 비교
            if validateAnswer(userInputAnswer, correctAnswer) {
                print("게임을 종료합니다.") // 정답을 맞추면 게임 종료
                break
            }
        }
    }
}

// 0~9 사이의 서로 다른 3자리 랜덤 숫자 생성
func makeAnswer() -> [Int] {
    var numbers = (0...9).shuffled() // 0~9까지 무작위 섞기
    
    // 첫 번째 숫자가 0이면 0이 아닌 숫자와 교환
    if numbers[0] == 0 {
        if let nonZeroIndex = numbers.firstIndex(where: { $0 != 0 }) {
            numbers.swapAt(0, nonZeroIndex)
        }
    }
    
    return Array(numbers.prefix(3)) // 앞에서 3개의 숫자 선택하여 반환
}

// 게임 시작 메시지 출력
func gameIntroMessage() {
    print(" < 게임을 시작합니다 > ")
}

// 사용자 입력을 받는 메서드 (올바른 입력이 들어올 때까지 반복)
func inputAnswer() -> [Int] {
    while true {
        print("숫자를 입력하세요.")

        if let input = readLine(), let answer = validateInputAnswer(input) {
            return answer
        }
    }
}

// 입력값 검증 (유효한 3자리 숫자인지 확인) → 유효하면 숫자 배열 반환, 유효하지 않으면 nil 반환
func validateInputAnswer(_ input: String) -> [Int]? {
    // 입력값이 숫자로만 이루어져 있는지 확인
    guard input.allSatisfy({ $0.isNumber }) else {
        print("숫자가 아닌 문자가 포함되어 있습니다. 다시 입력해주세요.\n")
        return nil
    }

    // 문자열을 숫자 배열로 변환
    let inputAnswer = input.compactMap { $0.wholeNumberValue }

    guard !inputAnswer.isEmpty else {
        print("공백 입력은 허용되지 않습니다. 숫자를 입력해주세요.\n")
        return nil
    }

    guard inputAnswer.count == 3 else {
        print("3개의 숫자만 입력 가능합니다.\n")
        return nil
    }

    guard inputAnswer.allSatisfy({ (0...9).contains($0) }) else {
        print("0 - 9까지의 숫자만 입력 가능합니다.\n")
        return nil
    }

    guard Set(inputAnswer).count == inputAnswer.count else {
        print("숫자는 각각 한 개씩만 사용할 수 있습니다. ( 두 번 사용 불가능 )\n")
        return nil
    }

    guard inputAnswer.first != 0 else {
        print("첫 번째 숫자는 0이 될 수 없습니다.\n")
        return nil
    }

    return inputAnswer // 모든 검증 통과 시 변환된 숫자 배열 반환
}


// 정답과 사용자 입력 비교 (스트라이크 & 볼 판정)
func validateAnswer(_ userInput: [Int], _ correctAnswer: [Int]) -> Bool {
    let (strikeCount, ballCount) = calculateScore(userInput, correctAnswer) // 점수 계산
    displayResult(strikeCount, ballCount) // 결과 출력
    
    return strikeCount == 3 // 3 스트라이크면 정답
}

// 스트라이크 & 볼 개수 계산
private func calculateScore(_ userInput: [Int], _ correctAnswer: [Int]) -> (strike: Int, ball: Int) {
    var strike = 0
    var ball = 0
    
    for (index, number) in userInput.enumerated() {
        if number == correctAnswer[index] {
            strike += 1 // 같은 자리 같은 숫자 → 스트라이크 증가
        } else if correctAnswer.contains(number) {
            ball += 1 // 숫자가 포함되지만 위치가 다르면 → 볼 증가
        }
    }
    
    return (strike, ball) // 튜플로 결과 반환
}

//결과 출력 (스트라이크 & 볼 개수에 따른 메시지)
private func displayResult(_ strike: Int, _ ball: Int) {
    if strike == 3 {
        print("정답입니다!") // 3 스트라이크 시 정답 처리
    } else if strike == 0 && ball == 0 {
        print("Nothing") // 스트라이크와 볼이 모두 없을 때
    } else {
        print("\(strike) 스트라이크, \(ball) 볼") // 결과 출력
    }
}

