//
//  PhotoViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 7/30/25.
//

import UIKit

class PhotoViewController: UIViewController {
    
    let firstList = ["고래밥", "칙촉", "카스타드"]
    let secondList = ["아이폰", "아이패드", "애플워치", "맥북"]

    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        return tableView
    }()
    
    lazy var authorTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blue
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        return tableView
    }()
     
    let button = {
       let view = UIButton()
        view.setTitle("통신 시작하기", for: .normal)
        view.backgroundColor = .yellow
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        
        if tableView == authorTableView {
            let row = secondList[indexPath.row]
            cell.titleLabel.text = row
        }
        else {
            let row = firstList[indexPath.row]
            cell.titleLabel.text = row
        }
        
        return cell
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
    }
    
}

#if DEBUG
#Preview {
    PhotoViewController()
}
#endif
