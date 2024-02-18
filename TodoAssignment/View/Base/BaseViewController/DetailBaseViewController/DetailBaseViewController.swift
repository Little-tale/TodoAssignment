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
        // 상황에 맞는 메뉴 상호 작용이 컨트롤의 기본 작업인지 여부를 결정하는 부울 값입니다.
        button.showsMenuAsPrimaryAction = true
        //button.changesSelectionAsPrimaryAction = true
        
        let menuItems = actions.map { title, action in
            UIAction(title: title) { buttonAction in
                action()
            }
        }
        
        button.menu = UIMenu(children: menuItems)
        
        
      // MARK: 공식문서
       //컨트롤이 상황에 맞는 메뉴 상호 작용을 활성화하는지 여부를 결정하는 부울 값입니다.
        button.isContextMenuInteractionEnabled = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func setupSortActionPlus(for button: UIButton, actions: [UIAction]) {
        

        // MARK: 공식문서
         //컨트롤이 상황에 맞는 메뉴 상호 작용을 활성화하는지 여부를 결정하는 부울 값입니다.
        
        button.menu = UIMenu(children: actions)
        button.setTitle("정렬방식", for: .normal)
        button.showsMenuAsPrimaryAction = true
        button.isContextMenuInteractionEnabled = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    // MARK: 밖에서 할 액션 세팅 메서드
    /// 액션을 새팅합니다,
//    func settingAction(for button: UIButton, actions: [(String, ()->Void)]) {
//        setupSortAction(for: button, actions: actions)
//    }
 
}



//MARK: 공식문서에 있는 자료 토대로 재현
// -> 꾹 눌러서 나오는 메뉴라고 한다
// 해당뷰에 add하고 -> 딜리게이트 구현해야한다.

//extension DetailViewController: UIContextMenuInteractionDelegate {
//    // 각 보기에 상황에 맞는 메뉴가
//    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//        <#code#>
//    }
//    
//    
//}
