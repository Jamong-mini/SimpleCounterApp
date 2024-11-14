## 1\. SnapKit 설정

코드베이스 UI를 작성할 때, 조금 더 간결한 문법을 사용하도록 도와주는 서드파티이다.  
`NSLayoutConstraint`의 제약조건을 보다 편하고 짧게 작성할 수 있게 도와준다.

### Swift Package Manager (SPM) 사용

프로젝트에 서드파티 라이브러리를 가져와서 사용할 수 있도록 도와주는 도구며 애플이 지원하는 퍼스트 파티 도구이다.

추가하는 방법은 아래와 같다.

    1. 프로젝트 파일에서 TARGETS을 선택한다.

    2. General 하단에 Frameworks, Libraries의 `+`버튼을 클릭한다.

[##_Image|kage@8rS4O/btsKI2eBFtB/WUEXgPsVc5zlsd64W7RWxK/img.png|CDM|1.3|{"originWidth":1142,"originHeight":692,"style":"alignCenter","filename":"스크린샷 2024-11-14 오후 4.23.09.png"}_##]

   3. Add Other…을 클릭 후 Add Package Dependency…를 선택

[##_Image|kage@BIgah/btsKIubL3Od/6oFQaK5JmaaT0jqtkzG621/img.png|CDM|1.3|{"originWidth":1140,"originHeight":749,"style":"alignCenter"}_##]

   4. Github의 SnapKit 공식 레파지토리에서 Clone url을 가져온다.

[##_Image|kage@b7LBZZ/btsKIuCRNS7/UVMVe5B7k4ryV8n95XW5VK/img.png|CDM|1.3|{"originWidth":1253,"originHeight":557,"style":"alignCenter"}_##]

   5. 검색창에 Clone url을 넣고 검색한다.

[##_Image|kage@zgqiw/btsKH8tgDCH/AyhZDzB1aACnBkApj3uak1/img.png|CDM|1.3|{"originWidth":1080,"originHeight":605,"style":"alignCenter"}_##]

   6. snapkit 패키지를 Add Package를 눌러서 추가한다.

---

## 2\. 카운터 앱 요구사항

-   **숫자를 띄울 라벨**
    -   숫자 라벨 : Int형 -> 0 부터 시작
    -   textColor : white
    -   font: boldSystem -> Size: 45
    -   textAlignment: center
    -   width: 80
    -   constraint: superView 와 Center가 같게 설정
-   **감소, 증가 버튼 구현**
    -   backgroundColor: 감소 버튼은 red, 증가 버튼은 blue
    -   title: 감소, 증가
    -   textColor: white
    -   width: 80
    -   height: 30
    -   cornerRadius: 8
    -   constraint:
        -   CenterY는 모두 숫자 라벨과 같게 설정
        -   감소 버튼은 라벨로부터 왼쪽으로 32 떨어지게 설정
        -   증가 버튼은 라벨로부터 오른쪽으로 32 떨어지게 설정
-   **초기화 버튼 구현**
    -   backgroundColor: gray
    -   title: 초기화
    -   textColor: white
    -   width: 80
    -   height: 30
    -   cornerRadius: 8
    -   constraint:
        -   CenterX는 숫자 라벨과 같게 설정
        -   숫자라벨과 60 떨어지게 설정

### 요구사항 구조 정리

요구사항으로 봤을때 버튼 3개와 라벨 1개로 이루어진 간단한 앱을 만들면 된다.  
각 버튼의 공통된 부분이 많기에 재사용성을 높일 수 있는 **커스텀 UI 컴포넌트**를 만들어서 사용하고자 한다.  
또한 객체도 적고 하나의 화면으로만 이루어져있어서, 하나의 뷰 컨트롤러 내에서 모든 작업을 수행하고자 한다.

---

## 3\. 커스텀 UI 컴포넌트 (버튼) 만들기

요구사항에서 스타일의 공통점과 개별점은 아래와 같다.  
공통 - `textColor`, `width`, `height`, `cornerRadius`  
개별 - `backgroundColor`, `constraint`, `title`

따라서 `CustomButton` 클래스를 생성하여 초기화부분에 개별 스타일로 설정하고자 한다.

### CustomButton Code

-   CustomButton을 초기화 설정하는 과정에서 `super.init`을 주지 않으면 오류가 걸린다고 한다.
    -   이 부분은 `Class`의 `init`과 `super init`에 대해 학습하는 시간을 가져야 할 것 같다.

[##_Image|kage@pxj7G/btsKIRxEp43/Pp6L3xi3vPJK1cMWnm1k1k/img.png|CDM|1.3|{"originWidth":842,"originHeight":300,"style":"alignCenter"}_##]

---

## 4\. SnapKit을 사용하면 편한점 (전체 UI 포함)

### SnapKit을 사용하면 편한점\[1\]

SnapKit을 사용한 코드와 사용하지 않은 코드를 비교해 보자

#### **SnapKit 사용**

```
class CustomButton: UIButton {
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitleColor(.white, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 8
        self.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
    }
    required init?(coder: NSCoder) {
        print("이 초기화 메서드는 구현되지 않았습니다.") 
        return nil
    }
}
```

#### **구조 이해자료**

아래 방식으로 코드를 가독성은 지키면서 더 짧게 작성할 수 있다.

```
        self.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
---------------------------------------------------------
        self.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
```

**SnapKit 미사용**

```
class CustomButton: UIButton {
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitleColor(.white, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 8
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    required init?(coder: NSCoder) {
        print("이 초기화 메서드는 구현되지 않았습니다.") 
        return nil
    }
}
```

두개를 비교하면

-   `translatesAutoresizingMaskIntoConstraints = false`
-   `widthAnchor.constraint(equalToConstant: 80).isActive = true`
-   `heightAnchor.constraint(equalToConstant: 30).isActive = true`

로 사용했을때와 사용하지 않았을 때의 코드 길이가 확연히 차이난다는 것을 알 수 있다.

### SnapKit을 사용하면 편한점\[2\]

두번 째로는 UI를 전체 구성하고 제약조건을 설정할 때 느낄 수 있다.

아래 코드는 전체 UI를 구성한 코드이다.

```
import UIKit
import SnapKit

class ViewController: UIViewController {

    private var number: Int = 0
    let label = UILabel()
    let minusButton = CustomButton(backgroundColor: .red, title: "감소")
    let plusButton = CustomButton(backgroundColor: .blue, title: "증가")
    let clearButton = CustomButton(backgroundColor: .gray, title: "초기화")

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    /// 메인 뷰 UI 설정
    private func configureUI() {
        view.backgroundColor = .black
        // Label 설정
        label.text = "\(number)"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 52)
        label.textAlignment = .center

        // View에 UI 넣기
        [label, minusButton, plusButton, clearButton]
            .forEach { view.addSubview($0) }

        // 제약 조건 설정
        label.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.center.equalToSuperview()
        }

        minusButton.snp.makeConstraints{
            $0.centerY.equalTo(label.snp.centerY)
            $0.trailing.equalTo(label.snp.leading).inset(32)
        }

        plusButton.snp.makeConstraints{
            $0.centerY.equalTo(label.snp.centerY)
            $0.leading.equalTo(label.snp.trailing).offset(32)
        }

        clearButton.snp.makeConstraints{
            $0.centerX.equalTo(label.snp.centerX)
            $0.top.equalTo(label.snp.bottom).offset(60)
        }
    }
}

/// CustonButton UI Component
class CustomButton: UIButton {

    /// CustomButton UI Component 초기화
    /// - Parameters:
    ///   - backgroundColor: 버튼 색 넣기
    ///   - title: 버튼 텍스트 넣기
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitleColor(.white, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 8
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    required init?(coder: NSCoder) {
        print("이 초기화 메서드는 구현되지 않았습니다.")
        return nil
    }
}
```

#### **Tip (SnapKit 과 무관함)**

```
// View에 UI 넣기
[label, minusButton, plusButton, clearButton]
    .forEach { view.addSubview($0) }
```

```
view.addSubview(label) 
view.addSubview(minusButton) 
view.addSubview(plusButton) 
view.addSubview(clearButton)
```

두 코드는 같은 코드로 `forEach` 고차함수를 사용하여 배열 안의 요소들을 반복 처리하는 방법으로 아래와 비교하면 더 간결한 코드를 만들 수 있다.

### NSLayoutConstraint을 사용하지 않음

아래 두 코드를 비교해보면 `NSLayoutConstraint`구문이 사라졌을 뿐인데 가독성을 해치지 않으며 훨씬 간결한 코드가 되었다.

**SnapKit 사용**

```
// 제약 조건 설정
label.snp.makeConstraints {
    $0.width.equalTo(80)
    $0.center.equalToSuperview()
}

minusButton.snp.makeConstraints{
    $0.centerY.equalTo(label.snp.centerY)
    $0.trailing.equalTo(label.snp.leading).inset(32)
}

plusButton.snp.makeConstraints{
    $0.centerY.equalTo(label.snp.centerY)
    $0.leading.equalTo(label.snp.trailing).offset(32)
}

clearButton.snp.makeConstraints{
    $0.centerX.equalTo(label.snp.centerX)
    $0.top.equalTo(label.snp.bottom).offset(60)
}
```

#### **SanpKit 미사용**

```
// translatesAutoresizingMaskIntoConstraints를 false로 설정
label.translatesAutoresizingMaskIntoConstraints = false
minusButton.translatesAutoresizingMaskIntoConstraints = false
plusButton.translatesAutoresizingMaskIntoConstraints = false
clearButton.translatesAutoresizingMaskIntoConstraints = false

// 제약 조건 설정
NSLayoutConstraint.activate([
    // label 제약 조건
    label.widthAnchor.constraint(equalToConstant: 80),
    label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    label.centerYAnchor.constraint(equalTo: view.centerYAnchor),

    // minusButton 제약 조건
    minusButton.centerYAnchor.constraint(equalTo: label.centerYAnchor),
    minusButton.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -32),

    // plusButton 제약 조건
    plusButton.centerYAnchor.constraint(equalTo: label.centerYAnchor),
    plusButton.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 32),

    // clearButton 제약 조건
    clearButton.centerXAnchor.constraint(equalTo: label.centerXAnchor),
    clearButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 60)
])
```

---

## 5\. 기능 구현

요구사항에서 증가 버튼을 누르면 숫자 라벨이 +1 씩 증가 되어야하고, 감소 버튼을 누르면 숫자 라벨이 -1 씩 감소 되어야하며, 초기화 버튼을 누르면 숫자 라벨이 0이 되어야한다.

따라서 코드구현은 아래와 같다.

```
/// 메인 뷰 UI 설정
private func configureUI() {
    ...
    minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    ...

    @objc
    private func minusButtonTapped() {
        self.number -= 1
        label.text = "\(number)"
    }

    @objc
    private func plusButtonTapped() {
        self.number += 1
        label.text = "\(number)"
    }

    @objc
    private func clearButtonTapped() {
        self.number = 0
        label.text = "\(number)"
    }
}
```

---

## 6\. SnapKit 빌드 오류

Swift Package Manager를 사용하여 Snapkit을 사용하면 빌드 오류가 종종 발생한다고 한다.

> No such file or directory: '/Users/Jamong/Library/Developer/Xcode/DerivedData/SimpleCounterApp-dpxghlehirdvvlavjiycfczdzvqk/Build/Products/Debug-iphonesimulator/PackageFrameworks/SnapKit-Dynamic.framework/SnapKit-Dynamic'

해당 사항은 SnapKit-Dynamic을 삭제하면 되는데 설치를 했던 것처럼 `-`를 눌러 `SnapKit-Dynamaic`을 삭제하면 된다.

[##_Image|kage@FrsEK/btsKIEL6zh8/xX22DdeNWSelD7mOxF423K/img.png|CDM|1.3|{"originWidth":1137,"originHeight":534,"style":"alignCenter"}_##]

---

## 7\. 학습 한 것 또는 해야할 것

### 학습한 것

해당 과제를 하면서 SnapKit을 처음 사용해보았고 사용하는 방법을 익혔다.  
항상 고민했던 것이 **커스텀 UI 컴포넌트**들을 만들어서 간결하고 가독성 좋게 만들어도 **제약조건** `NSLayoutConstraint.activate([])`구문 때문에 코드가 길어지는 것이 좋아보이지 않아서 신경쓰였는데 SnapKit을 쓰면서 감탄했다.

### 해야할 것

2단계 초기화 학습

-   `Class`의 `init`과 `super init`에 대해 학습하는 시간을 가져야 할 것 같다.
