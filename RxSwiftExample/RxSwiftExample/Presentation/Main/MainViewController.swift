//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/06/30.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    let menuArray = [VCData(title: "데이터 전달 [델리게이트 패턴]", vc: DelegateFirstViewController()),
                     VCData(title: "데이터 전달 [클로저]", vc: ClosureFirstViewController()),
                     VCData(title: "데이터 전달 [RxSwift]", vc: SendDataViewController()),
                     VCData(title: "Rx + TextField", vc: RxAndTextFieldViewController()),
                     VCData(title: "NewsList [MVC]", vc: MVC_ViewController()),
                     VCData(title: "NewsList [MVVM]", vc: MVVM_ViewController())]
    
    let menuRelay = BehaviorRelay<[VCData]>(value: [])
    
    lazy var tableView = UITableView().then {
        $0.register(MenuCell.self, forCellReuseIdentifier: MenuCell.id)
        $0.separatorStyle = .singleLine
        $0.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bind()
    }
    
    fileprivate func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    fileprivate func bind() {
        menuRelay.accept(menuArray)
        
        menuRelay.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items) { table, index, item in
                guard let cell = table.dequeueReusableCell(withIdentifier: MenuCell.id) as? MenuCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.configure(item: item.title)
                return cell
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                AppDelegate.shared.pushViewController(self.menuArray[indexPath.row].vc, animated: true)
            }).disposed(by: disposeBag)
        
    }
}

class MenuCell: UITableViewCell {
    static let id = "MenuCell"
    
    lazy var titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20.sizeToFit(), weight: .bold)
        $0.textColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: String) {
        titleLabel.text = item
    }
    
    fileprivate func setupLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

struct VCData {
    let title: String
    let vc: UIViewController
}
