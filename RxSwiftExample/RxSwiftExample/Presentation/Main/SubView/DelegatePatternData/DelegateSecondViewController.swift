//
//  DelegateSecondViewController.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/07/04.
//

import Foundation
import UIKit

class DelegateSecondViewController: UIViewController {
    // MARK: Properties
    weak var delegate: DeliveryDataProtocol?
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        guard let text = myTextField.text else { return }
        
        delegate?.delvery(text)
        self.dismiss(animated: true)
    }
    
    // MARK: View
    lazy var myTextField = UITextField().then {
        $0.placeholder = "전달할 데이터를 입력하세요"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.borderStyle = .roundedRect
    }
    
    lazy var sendButton = UIButton().then {
        $0.setTitle("전달", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.layer.cornerRadius = 4
        $0.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(myTextField)
        view.addSubview(sendButton)
        
        myTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        sendButton.snp.makeConstraints {
            $0.top.equalTo(myTextField.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 70, height: 40))
        }
    }
}
