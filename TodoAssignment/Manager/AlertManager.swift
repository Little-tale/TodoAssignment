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
    
    func showAlert(error: Error) -> UIAlertController {
        var alert = UIAlertController()
        if let error = error as? RealmErrorCase {
            alert.title = error.errorTitle
            alert.message = error.errorMessage
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alert.dismiss(animated: true)
            }
            return alert
        }
        alert.title = "에러"
        alert.message = "관리자에게 문의하세요"
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            alert.dismiss(animated: true)
        }
        return alert
}
    
}
