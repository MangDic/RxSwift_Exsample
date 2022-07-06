//
//  SecondNextViewController.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/06/30.
//

import Foundation
import UIKit
import RxRelay
import RxSwift

class SecondNextViewController: UIViewController {
    var disposeBag = DisposeBag()
    let textRelay = BehaviorRelay<String>(value: "")
    
    lazy var myTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 12.sizeToFit(), weight: .bold)
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.backgroundColor = .white
        $0.borderStyle = .roundedRect
        $0.placeholder = "텍스트를 입력하세요"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(myTextField)
        
        myTextField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(40.sizeToFit())
        }
    }
    
    fileprivate func bind() {
        myTextField.rx.text
            .subscribe(onNext: { [weak self] text in
                guard let text = text else { return }
                self?.textRelay.accept(text)
            }).disposed(by: disposeBag)
    }
}
