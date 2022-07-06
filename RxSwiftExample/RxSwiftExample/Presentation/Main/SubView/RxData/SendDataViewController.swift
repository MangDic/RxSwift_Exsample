//
//  SendDataViewController.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/06/30.
//

import Foundation
import UIKit
import RxSwift

class SendDataViewController: UIViewController {
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
        moveButton.rx.tap
            .subscribe(onNext: {
                AppDelegate.shared.pushViewController(self.nextVC, animated: true)
            }).disposed(by: disposeBag)
        
        nextVC.textRelay.subscribe(onNext: { [weak self] text in
            if text != "" { self?.myLabel.text = text }
        }).disposed(by: disposeBag)
    }
    
    // MARK: View
    lazy var nextVC = SecondNextViewController()
    
    lazy var myLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20.sizeToFit(), weight: .bold)
        $0.textColor = .black
        $0.text = "Rx로 가져온 데이터"
    }
    
    lazy var moveButton = UIButton().then {
        $0.setTitle("입력하러 가기", for: .normal)
        $0.layer.cornerRadius = 8.sizeToFit()
        $0.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12.sizeToFit(), weight: .bold)
        $0.titleLabel?.textColor = .white
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(myLabel)
        view.addSubview(moveButton)
        
        myLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        moveButton.snp.makeConstraints {
            $0.top.equalTo(myLabel.snp.bottom).offset(20.sizeToFit())
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 120.sizeToFit(), height: 40.sizeToFit()))
        }
    }
}
