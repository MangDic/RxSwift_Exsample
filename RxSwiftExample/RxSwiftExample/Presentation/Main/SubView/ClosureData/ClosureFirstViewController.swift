//
//  ClosureFirstViewController.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/07/04.
//

import Foundation
import UIKit

class ClosureFirstViewController: UIViewController {
    // MARK: Properties
    lazy var secondVC = ClosureSecondViewController()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        secondVC.dataSendClosure = { [weak self] data in
            guard let `self` = self else { return }
            self.recievedLabel.text = data
        }
        present(secondVC, animated: true)
    }
    
    // MARK: View
    lazy var recievedLabel = UILabel().then {
        $0.text = "클로저로 받은 데이터"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    lazy var nextButton = UIButton().then {
        $0.setTitle("이동", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.layer.cornerRadius = 4
        $0.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(recievedLabel)
        view.addSubview(nextButton)
        
        recievedLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(recievedLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 70, height: 40))
        }
    }
}
