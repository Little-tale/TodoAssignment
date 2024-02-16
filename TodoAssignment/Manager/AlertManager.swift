//
//  Alert<anager.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/16/24.
//


import UIKit

class AlertManager {
    
    func showAlert(title: String, message: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true)
        }
        return alert
    }
    
}
