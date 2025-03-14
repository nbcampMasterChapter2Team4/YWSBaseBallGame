//
//  ShowGameDescription.swift
//  YWSBaseBallGame
//
//  Created by 양원식 on 3/14/25.
//

// 야구 게임 설명을 출력하는 함수
func showGameDescription() {
    print("\n" + String(repeating: "=", count: 40))
    print("⚾ 숫자 야구 게임 설명 ⚾")
    print(String(repeating: "=", count: 40))
    
    print("""
    1. 컴퓨터가 1~9 사이의 **서로 다른 3자리 숫자**를 생성합니다.
    2. 플레이어는 같은 규칙으로 **3자리 숫자를 입력**합니다.
    3. 입력한 숫자와 컴퓨터의 숫자를 비교하여 다음 규칙에 따라 결과를 표시합니다.

       🟡 **스트라이크**: 숫자와 위치가 모두 같음
       🟢 **볼**: 숫자는 같지만 위치가 다름
       ❌ **아웃**: 하나도 맞지 않음

    예제:
    - 정답: 472
    - 입력: 432 → 🟡🟢 (4는 스트라이크, 3은 없음, 2는 볼)
    - 입력: 756 → 🟢 (7은 볼, 5와 6은 없음)
    - 입력: 472 → 🎉 **정답!**

    4. 3스트라이크(🟡🟡🟡)가 나오면 게임이 종료됩니다.
    """)

    print("\n" + String(repeating: "=", count: 40))
    print("메인 메뉴로 돌아가려면 Enter를 눌러주세요.")
    print(String(repeating: "=", count: 40))

    _ = readLine() // 사용자 입력을 기다려서 자연스럽게 진행
}

