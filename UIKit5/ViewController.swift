//
//  ViewController.swift
//  UIKit5
//
//  Created by 송재훈 on 7/29/25.
//

import UIKit

class ViewController: UIViewController {
    let imageView = UIImageView()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        qos()
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "초기 화면"
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(button)
                
        imageView.backgroundColor = .systemCyan
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        button.setTitle("1312312", for: .normal)
        button.backgroundColor = .systemGray
        button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12).isActive = true
        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 12).isActive = true
        
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    func serialSync() {
        print(#function, "start")
        
        DispatchQueue.main.sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
            
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        print()
        print(#function, "end")
    }
    
    func serialAsync() {
        print(#function, "start")
        
        DispatchQueue.main.async {        
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print()
        print(#function, "end")
    }
    
    func concurrentAsync() {
        print(#function, "start")
        
        DispatchQueue.global().async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print(#function, "end")
    }
    
    func concurrentSync() {
        print(#function, "start")
        
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print()
        print(#function, "end")
    }
    
    func qos() {
        print(#function, "start")
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        for i in 201...300 {
            DispatchQueue.global(qos: .userInteractive).async {
                print(i, terminator: " ")
            }
        }
        
        print()
        print(#function, "end")
    }
    
    @objc func buttonClicked() {
        print(#function)
        print("1")
        DispatchQueue.global().async {
            print("2")
            let url = URL(string: "https://apod.nasa.gov/apod/image/2507/Helix_GC_1080.jpg")!
            let data = try! Data(contentsOf: url)
            let image = UIImage(data: data)
            print("3")
            
            DispatchQueue.main.sync {
                print("4")
                self.imageView.image = image
                print("5")
            }
            print("6")
        }
        print("7")
    }
}

