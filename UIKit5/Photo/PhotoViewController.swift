//
//  PhotoViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 7/30/25.
//

import UIKit
import Alamofire

class PhotoViewController: UIViewController {
    
    var firstList = [Photo]()
    var secondList = [Photo]()
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(PhotoTableViewCell.self)
        
        return tableView
    }()
    
    lazy var authorTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blue
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuthorTableViewCell.self)
        
        return tableView
    }()
    
    let button = {
        let view = UIButton()
        view.setTitle("통신 시작하기", for: .normal)
        view.backgroundColor = .systemBrown
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == authorTableView {
            return secondList.count
        }
        else {
            return firstList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == authorTableView {
            let cell = tableView.dequeueReusableCell(AuthorTableViewCell.self, for: indexPath)
            let row = secondList[indexPath.row]
            cell.authorLabel.text = row.author
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(PhotoTableViewCell.self, for: indexPath)
            let row = firstList[indexPath.row]
            cell.titleLabel.text = row.author
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        vc.textFieldHander = {
            self.button.setTitle($0, for: .normal)
        }
        let nav = UINavigationController(rootViewController: vc)
        
//        navigationController?.pushViewController(vc, animated: true)
        present(nav, animated: true)
    }
}

extension PhotoViewController {
    
    func configureHierarchy() {
        view.addSubview(authorTableView)
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    func configureLayout() {
        
        button.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
            make.top.equalTo(button.snp.bottom)
        }
        
        authorTableView.snp.makeConstraints { make in
            make.leading.equalTo(tableView.snp.trailing)
            make.verticalEdges.equalTo(tableView)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        navigationItem.title = "통신 테스트"
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
}

extension PhotoViewController {
    @objc func buttonClicked(_ sender: UIButton) {
        request()
    }
    
    func request() {
        let group = DispatchGroup()
        
        self.call(group: group, url: "https://picsum.photos/v2/list?page=1") { value in
            self.firstList.append(contentsOf: value)
        }
        
        self.call(group: group, url: "https://picsum.photos/v2/list?page=3") { value in
            self.secondList.append(contentsOf: value)
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
            self.authorTableView.reloadData()
        }
    }
    
    func call(group: DispatchGroup, url: String, completionHandler: @escaping ([Photo]) -> ()) {
        group.enter()
        AF.request(URLRequest(url: URL(string: url)!))
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Photo].self) {
                defer { group.leave() }
                guard let value = try? $0.result.get() else { return }
                completionHandler(value)
            }
    }
}

#if DEBUG
#Preview {
    UINavigationController(rootViewController: PhotoViewController())
}
#endif
