# RxSwift_Exsample

## 데이터 전달 코드 비교!

#### - 델리게이트 패턴 사용
#### - 클로저 사용
#### - Rx 사용

---
## Observable과 Subject 차이 예제

#### Observable은 새로운 Observer가 구독할 때마다 Observable 안에 있는 코드를 다시 돌린다! (그래서 구독할 때마다 값이 계속 바뀜 -> Cold Observable / unicast)
#### Subject는 새로운 Observer가 구독해도 현재 구독하고 있는 모든 Observer들에게 같은 값을 방출한다! (Hot Observable / multicast)

---
## Rx 사용 예제

#### - 텍스트 필드 입력에 반응하여 입력 받은 문자를 출력 및 검증

---
## MVC와 MVVM 코드 비교

#### - 뉴스 API를 연동하여 데이터를 가져옵니다
#### - MVC의 테이블 뷰는 일반적인 델리게이트로 구현하였습니다
#### - MVVM의 테이블 뷰는 Rx를 사용하여 구현하였습니다

---
## Warning

#### - 이해를 돕기 위해 기능에 맞지 않는 네이밍이 있습니다 (ex MVVM_ViewController 등)
