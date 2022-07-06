//
//  MVC_ViewController.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/07/05.
//

import Foundation
import UIKit

class MVC_ViewController: UIViewController {
    // MARK: Properties
    var newsData: [NewsInfo]!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTableView()
        getNewsData()
    }
    
    // MARK: Method
    /// 뉴스 데이터를 가져오기 위한 네트워크 통신
    fileprivate func getNewsData() {
        newsData = [NewsInfo]()
        
        let url = URL(string: NetworkController.baseUrl + "top-headlines?country=kr&apiKey=026fbf6b403f4f25b582c17a68ab46e4")!
        let test = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            let successRange = 200..<300
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let item = try decoder.decode(News.self, from: data)
                
                for article in item.articles {
                    let title = article?.title ?? "Null"
                    let description = article?.description ?? "Null"
                    
                    self?.newsData.append(NewsInfo(title: title, description: description))
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            catch {
                print(error)
            }
        })
        test.resume()
    }
    
    fileprivate func setupTableView() {
        //tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: View
    lazy var tableView = UITableView().then {
        $0.separatorStyle = .singleLine
        $0.register(NewsCell.self, forCellReuseIdentifier: NewsCell.id)
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

// MARK: TableView DataSource
extension MVC_ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.id, for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        cell.configure(data: newsData[indexPath.row])
        return cell
    }
}

// MARK: TAbleView Delegate
extension MVC_ViewController: UITableViewDelegate {
    
}
