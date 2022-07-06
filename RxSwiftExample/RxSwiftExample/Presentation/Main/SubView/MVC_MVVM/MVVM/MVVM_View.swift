//
//  MVVM_View.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/07/05.
//

import Foundation
import UIKit
import RxRelay
import RxSwift

class MVVM_View: UIView {
    var disposeBag = DisposeBag()
    let dataRelay = BehaviorRelay<[NewsInfo]>(value: [])
    
    lazy var tableView = UITableView().then {
        $0.separatorStyle = .singleLine
        $0.register(NewsCell.self, forCellReuseIdentifier: NewsCell.id)
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Dependency Injection
    func setupDI(relay: BehaviorRelay<[NewsInfo]>) {
        relay.bind(to: self.dataRelay).disposed(by: disposeBag)
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    fileprivate func setupTableView() {
        /// Set TableView Data Source
        dataRelay.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items) { table, row, item in
                guard let cell = table.dequeueReusableCell(withIdentifier: NewsCell.id) as? NewsCell else { return UITableViewCell() }
                cell.configure(data: item)
                return cell
            }.disposed(by: disposeBag)
    }
}
