//
//  Observable_Subject_View.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/07/07.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class Observable_Subject_View: UIView {
    var disposeBag = DisposeBag()
    
    let observable = Observable<Int>.create { observer in
        observer.onNext(Int.random(in: 0...200))
        return Disposables.create()
    }
    let subject = BehaviorSubject<Int>(value: Int.random(in: 0...200))
    
    var observableIndex = 0
    var subjectIndex = 0
    
    lazy var buttonStack = UIStackView().then {
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    lazy var observableSubscriptionBtn = UIButton().then {
        $0.setTitle("Subscribe Observable", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        $0.titleLabel?.textColor = .white
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12.sizeToFit(), weight: .bold)
    }
    
    lazy var subjectSubscriptionBtn = UIButton().then {
        $0.setTitle("Subscribe Subject", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        $0.titleLabel?.textColor = .white
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12.sizeToFit(), weight: .bold)
    }
    
    lazy var observableObserverStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .fill
    }
    
    lazy var subjectObserverStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .fill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createObserverView(index: Int, isObserver: Bool) {
        lazy var stack = UIStackView().then {
            $0.spacing = 5
            $0.axis = .vertical
        }
        
        lazy var nameLabel = UILabel().then {
            $0.text = isObserver ? "\(index)번 째 Observable 옵저버" : "\(index)번 째 Subject 옵저버"
            $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        }
        
        lazy var valueLabel = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        }
        
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(valueLabel)
        
        if isObserver {
            observable.subscribe(onNext: {
                valueLabel.text = "value : \($0)"
            }).disposed(by: disposeBag)
            
            observableObserverStack.addArrangedSubview(stack)
        }
        else {
            subject.subscribe(onNext: {
                valueLabel.text = "value : \($0)"
            }).disposed(by: disposeBag)
            
            subjectObserverStack.addArrangedSubview(stack)
        }
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
        
        addSubview(buttonStack)
        addSubview(observableObserverStack)
        addSubview(subjectObserverStack)
        
        buttonStack.addArrangedSubview(observableSubscriptionBtn)
        buttonStack.addArrangedSubview(subjectSubscriptionBtn)
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(40.sizeToFit())
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40.sizeToFit())
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        observableObserverStack.snp.makeConstraints {
            $0.top.equalTo(buttonStack.snp.bottom).offset(40.sizeToFit())
            $0.left.equalToSuperview().inset(40.sizeToFit())
            $0.width.equalTo(UIScreen.main.bounds.width / 2 - 40.sizeToFit())
        }
        
        subjectObserverStack.snp.makeConstraints {
            $0.top.equalTo(buttonStack.snp.bottom).offset(40.sizeToFit())
            $0.right.equalToSuperview().inset(40.sizeToFit())
            $0.left.equalTo(observableObserverStack.snp.right)
        }
    }
    
    fileprivate func bind() {
        observableSubscriptionBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.observableIndex += 1
                self?.createObserverView(index: self!.observableIndex, isObserver: true)
            }).disposed(by: disposeBag)
        
        subjectSubscriptionBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.subjectIndex += 1
                self?.createObserverView(index: self!.subjectIndex, isObserver: false)
            }).disposed(by: disposeBag)
    }
}
