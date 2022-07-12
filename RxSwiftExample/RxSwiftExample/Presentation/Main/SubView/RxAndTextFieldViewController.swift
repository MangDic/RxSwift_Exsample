//
//  RxAndTextFieldViewController.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/06/30.
//

import Foundation
import UIKit
import RxSwift

class RxAndTextFieldViewController: UIViewController {
    // MARK: Properties
    var disposeBag = DisposeBag()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }
    
    // MARK: Binding
    fileprivate func bind() {
        myTextField.rx.text
            .subscribe(onNext: { [weak self] text in
                guard let `self` = self else { return }
                guard let text = text else { return }
                self.inputLabel.text = "입력한 텍스트 : \(text)"
                self.warningLabel.text = self.validateStringCount(text: text) ? "Great!" : "3글자 이상 입력하세요!"
                self.warningLabel.textColor = self.validateStringCount(text: text) ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            }).disposed(by: disposeBag)
    }
    
    // MARK: View
    lazy var myTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 12.sizeToFit(), weight: .bold)
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.backgroundColor = .white
        $0.borderStyle = .roundedRect
        $0.placeholder = "텍스트를 입력하세요"
    }
    
    lazy var inputLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 15.sizeToFit(), weight: .bold)
        $0.textColor = .black
    }
    
    lazy var warningLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 12.sizeToFit(), weight: .bold)
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(myTextField)
        view.addSubview(inputLabel)
        view.addSubview(warningLabel)
        
        myTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(40.sizeToFit())
            $0.height.equalTo(30.sizeToFit())
        }
        
        inputLabel.snp.makeConstraints {
            $0.bottom.equalTo(myTextField.snp.top).offset(-20.sizeToFit())
            $0.leading.trailing.equalToSuperview().inset(40.sizeToFit())
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(myTextField.snp.bottom).offset(20.sizeToFit())
            $0.leading.trailing.equalToSuperview().inset(40.sizeToFit())
        }
    }
    
    fileprivate func validateStringCount(text: String) -> Bool {
        return text.count > 2
    }
}
