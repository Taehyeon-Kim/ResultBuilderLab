/*:
 # Result Builder - 1

 SwiftUI에서 다음과 같이 코드를 작성할 수 있다.
 ```
 VStack(alignment: .leading) {
     Image(hotel.picture)
     Text(hotel.name)
     Text(hotel.price)
 }
 ```

 - Note:
 @resultBuilder는 여러 개의 컴포넌트를 하나의 컴포넌트로 사용할 수 있도록 도와준다. (= 함수 명령을 수집하고 단일 값을 생성한다.)
 
 ---
 
 - Note:
 결과 빌더 (result builder) 로 타입을 사용하기 위해 클래스, 구조체, 열거형에 이 속성을 적용한다. 결과 빌더 (result builder) 는 데이터 구조체를 단계별로 빌드하는 타입
 
 ---
 
 - Note:
 자연스럽고 선언적인 방법으로 중첩된 데이터 구조체를 생성하기 위해 도메인-특정 언어 (DSL) 를 구현하기 위해 결과 빌더를 사용
 
 -> 특정 공간에서 사용하기 위해 규칙을 정해놓자
 
 ---
 - Note:
 결과 빌더는 아래 설명한대로 정적 메서드를 구현한다. 결과 빌더의 모든 기능은 정적 메서드를 통해 노출되므로 해당 타입의 인스턴스를 초기화 하지 않는다.
 */

/*:
 ### 메서드와 타입
 
 - `buildBlock(_:)`
 - `buildPartialBlock(first:)`
 - `buildPartialBlock(accumulated:next:)`
 
 위의 메서드를 필수로 구현해야 한다. 나머지는 옵셔널이다.
 
 - `Expression` : 입력 타입
 - `Component`  : 부분 결과에 대한 타입
 - `FinalResult`: 최종 결과에 대한 타입
 
 정적 메서드를 보면 세가지 타입을 사용한다.
 
 */
 
/*:
 ### 특징
 - DSL의 도메인별 가정된 동작을 구현하는 데 도움이 됨
 - 함수, 메서드, 게터 또는 클로저에 적용
 - 결과를 사용할 수 있도록 암시적 메서드 호출로 문을 래핑
 - 함수의 반환 값
  - 함수 본문에 적용할 때 Swift는 정적 메서드에 대한 다양한 호출을 삽입
  - 호출은 궁극적으로 함수 본문에서 반환되는 값을 계산
  - 컴파일 타임에 동작
 
 ```
 VStack {
   Text("Title").font(.title)
   Text("Contents")
 }
 ```
 ```
 VStack.init(content: {
   let v0 = Text("Title").font(.title)
   let v1 = Text("Contents")
   return ViewBuilder.buildBlock(v0, v1)
 })
 ```
*/

/*:
언제 사용할 수 있을까?
 
 - Render Screens in UIKit
 - Build HTTP requests.
 - Draw shapes with Core Graphics.
 - Create Data Structures.
 - Generate attributed strings.
 - Create key-frame animations.
 */


//: Example 1, Basic


@resultBuilder
class ConvertStringBuilder {


  static func buildBlock(_ strings: String...) -> String {
    strings.joined(separator: ", ")
  }
}

@ConvertStringBuilder
func buildString() -> String {
  "A"
  "B"
  "C"
  "D"
}

buildString()

// "A, B, C, D"
//: Example 2, buildOptional(선택적 구축)
@resultBuilder
struct BreakfastBuilder {
  typealias Component = String
  
  static func buildBlock(_ foods: String...) -> String {
    foods.joined(separator: ", ")
  }

  // 조건부 블록에서 실행한 결과를 다음 메서드에서 받는다.
  // 단일 조건문을 사용한다면 다음 메서드를 실행시킬 수 있다.
  static func buildOptional(_ drink: String?) -> String {
    return drink ?? "No Drink"
  }

  static func buildEither(first component: String) -> String {
    return component
  }

  static func buildEither(second component: String) -> String {
    return component + " with sugar"
  }

  // Array를 넘기고 싶다면 for-loop을 생성한다.
  static func buildArray(_ drinks: [String]) -> String {
      "Drinks: " + drinks.joined(separator: ", ")
  }

  // MARK: - 다른 유형의 타입을 허용하고 싶을 때

  static func buildExpression(_ food: String) -> String {
      food
  }

  static func buildExpression(_ tissueAmount: Int) -> String {
      "\(tissueAmount) pieces of tissue"
  }
}

@BreakfastBuilder
func makeBreakfast(_ drink: Bool) -> String {
  "Egg"
  "Bread"

  if drink {
    "Milk"
  }
}

makeBreakfast(true)
makeBreakfast(false)

@BreakfastBuilder
func makeBreakfast2(_ drinkCoffee: Bool, _ another: Bool = false) -> String {
  "Egg"
  "Bread"

  if drinkCoffee {
    "Coffee"

    if another {
      "Tea"
    } else {
      "Green Tea"
    }
  }
}

makeBreakfast2(true)
makeBreakfast2(true, true)
makeBreakfast2(false)
makeBreakfast2(false, true)

//: Example 3, buildArray / Array를 넘기고 싶을 때

@BreakfastBuilder
func makeBreakfast3() -> String {
    "Egg"
    let v1 = "Bread"
    for d in ["Coffee", "Tea"] {
      "\(d)"
    }
}

makeBreakfast3()

//: Example 4, buildExpression / 타입 호환

@BreakfastBuilder
func makeBreakfast4() -> String {
    "Egg"
    "Bread"
    5
}

makeBreakfast4()


func build(@BreakfastBuilder _ content: () -> String) -> String {
  content()
}

var flag = true
let result = build {
  "skyblue"
  "violet"

  if flag {
    "white"
  }

  4
  5

  for item in ["red","blue","purple"] {
    item
  }
}
print(result)
