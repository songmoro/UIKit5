//
//  ViewController.swift
//  UIKit5
//
//  Created by 송재훈 on 7/29/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        alert(title: "타이틀", message: "메시지", defaultMessage: "확인하기") { [unowned self] in
            view.backgroundColor = .brown
        }
        
        alert(title: "타이틀", message: "메시지", defaultMessage: "확인하기")
    }
}

