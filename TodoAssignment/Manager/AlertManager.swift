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
        let alert = UIAlertController()
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
    
    func settingActionSheet(title: String,message: String? = nil, actions:[UIAlertAction]) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { action in
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        return alert
    }
    
    func actionSetting(title: String, compliteHandler: @escaping () -> Void) -> UIAlertAction{
        let action = UIAlertAction(title: title, style: .default) { action in
            compliteHandler()
        }
        return action
    }
    
    func settingActionSheet(title: String,message: String? = nil,
                            actions: @escaping()->Void) {
        
    }
    
    
}

