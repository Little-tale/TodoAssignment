//
//  Extension.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit

extension UIView {
    static var reuseabelIdentifier : String {
        return String(describing: self)
    }
}

extension UIViewController {
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        present(alert,animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alert.dismiss(animated: true)
        }
    }
}
