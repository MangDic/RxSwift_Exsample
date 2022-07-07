//
//  Observable_Subject_ViewController.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/07/07.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class Observable_Subject_ViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    lazy var subView = Observable_Subject_View()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        view.addSubview(subView)
        
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
