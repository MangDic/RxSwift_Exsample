//
//  MVC_Model.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/07/05.
//

import Foundation

struct News: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article?]
}

/// JSON에 맞는 형식
struct Article: Codable {
    let source: ArticleSource?
    let author: String?
    let title: String?
    let description: String?
    
    struct ArticleSource: Codable {
        let id: Int?
        let name: String?
    }
}

/// 예제에서 사용할 형식
struct NewsInfo {
    let title: String
    let description: String
}
