//
//  MVVM_ViewModel.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/07/05.
//

import Foundation
import RxSwift
import RxCocoa

class MVVM_ViewModel {
    var disposeBag = DisposeBag()
    let newsRelay = BehaviorRelay<[NewsInfo]>(value: [])
    
    struct Input {
        let requestTrigger: PublishRelay<Void>
    }
    
    struct Output {
        let newsRelay: BehaviorRelay<[NewsInfo]>
    }
    
    func transform(req: Input) -> Output{
        req.requestTrigger
            .bind(onNext: { [weak self] _ in
                self?.loadNewsData()
            }).disposed(by: disposeBag)
        return MVVM_ViewModel.Output(newsRelay: newsRelay)
    }
    
    /// 뉴스 데이터를 가져오기 위한 네트워크 통신
    fileprivate func loadNewsData() {
        let url = URL(string: NetworkController.baseUrl + "top-headlines?country=kr&apiKey=026fbf6b403f4f25b582c17a68ab46e4")!
        let test = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            let successRange = 200..<300
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {
                return
            }
            
            guard let data = data else { return }
            
            do {
                var newsData = [NewsInfo]()
                let decoder = JSONDecoder()
                let item = try decoder.decode(News.self, from: data)
                
                for article in item.articles {
                    let title = article?.title ?? "Null"
                    let description = article?.description ?? "Null"
                    
                    newsData.append(NewsInfo(title: title, description: description))
                }
                self?.newsRelay.accept(newsData)
            }
            catch {
                print(error)
            }
        })
        test.resume()
    }
}
