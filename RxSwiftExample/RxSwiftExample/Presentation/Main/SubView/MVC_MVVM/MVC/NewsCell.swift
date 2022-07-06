//
//  NewsCell.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/07/05.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    static let id = "NewsCEll"
    
    lazy var contentStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        $0.textAlignment = .left
    }
    
    lazy var descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        $0.textAlignment = .left
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: NewsInfo) {
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.description
    }
    
    fileprivate func setupLayout() {
        contentView.addSubview(contentStack)
        
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(descriptionLabel)
        
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
