//
//  UIViewController+.swift
//  UIKit5
//
//  Created by 송재훈 on 7/29/25.
//

import UIKit

extension UIViewController {
    func alert(title: String? = nil, message: String? = nil, defaultMessage: String, handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: defaultMessage, style: .default, handler: { _ in handler?() }))
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alertController, animated: true)
    }
}
