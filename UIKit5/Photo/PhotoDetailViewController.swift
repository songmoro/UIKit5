//
//  PhotoDetailViewController.swift
//  UIKit5
//
//  Created by 송재훈 on 7/31/25.
//

import UIKit
import SnapKit

class PhotoDetailViewController: UIViewController {
    let textField = UITextField()
    var textFieldHander: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        
        textField.placeholder = "값"
        textField.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview(\.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "결과"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissDetail))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @objc func dismissDetail() {
        textFieldHander?(textField.text!)
        
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
}
