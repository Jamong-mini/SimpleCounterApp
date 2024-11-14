// iOS App Project file for SimpleCounterApp - ViewController
// 작성일: 2024.11.14 (목요일)
//
// 작성자: Jamong
// 이 파일은 카운트 앱의 메인 화면을 구성한다.

import UIKit
import SnapKit

/// ViewController 클래스는 카운트 앱의 메인 뷰를 담당한다.
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
        
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
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
            $0.trailing.equalTo(label.snp.leading).offset(-32)
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
