//
//  MVVM_ViewController.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/07/05.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class MVVM_ViewController: UIViewController {
    let viewModel = MVVM_ViewModel()
    
    let requestTregger = PublishRelay<Void>()
    
    lazy var newsView = MVVM_View()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
        
        requestTregger.accept(())
    }
    
    fileprivate func setupLayout() {
        view.addSubview(newsView)
        
        newsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Binding
    fileprivate func bind() {
        let req = viewModel.transform(req: MVVM_ViewModel.Input.init(requestTrigger: requestTregger))
        
        newsView.setupDI(relay: req.newsRelay)
    }
}
