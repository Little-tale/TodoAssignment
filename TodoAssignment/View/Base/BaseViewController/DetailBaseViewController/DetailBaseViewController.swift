//
//  DetailBaseViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/17/24.
//

import UIKit

class DetailBaseViewController<T: BaseView> : BaseViewController {
    
    // weak var uiViewController: UIViewController?
    
    let baseHomeView = T()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        self.view = baseHomeView
    }
    
    // MARK: 액션 세팅 메서드
    /// 액션을 새팅합니다,
    private func setupSortAction(for button: UIButton, actions:[(String, ()->Void)] ){
        
        button.setTitle("정렬방식", for: .normal)
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        
        let menuItems = actions.map { title, action in
            UIAction(title: title) { buttonAction in
                action()
            }
        }
        
        button.menu = UIMenu(children: menuItems)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    // MARK: 밖에서 할 액션 세팅 메서드
    /// 액션을 새팅합니다,
    func settingAction(for button: UIButton, actions: [(String, ()->Void)]) {
        setupSortAction(for: button, actions: actions)
    }
 
}
