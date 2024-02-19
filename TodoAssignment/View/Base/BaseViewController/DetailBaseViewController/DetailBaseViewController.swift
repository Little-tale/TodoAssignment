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

    // MARK: 테스트공간
    var viewType: AllListCellCase?
    var repository = NewToDoRepository()
    
    lazy var testList = repository.DetailFilterViewForKeyPath(of: viewType ?? .all) {
        didSet{
//            print("asdsad")
//            NotificationCenter.default.post(name: NSNotification.Name("datas"), object: self, userInfo: ["data":true])
            // MARK: 노티피케이션 값전달로도 되질 않는다. 재사용 문제가 맞는거 같긴한데
        }
    }
    
    // Type -> (keyPath: String, ascending: Bool)
    // MARK: 각 정렬 기준을 잡습니다.
    var sortParam = testSortSction.title(ascending: true).parameter {
        didSet{
            guard let baseHomeView = baseHomeView as? DetailHomeView  else {
                return
            }
            testList = repository.DetailFilterViewForKeyPath(of: viewType ?? .all, sortParam: sortParam)
            baseHomeView.tableView.reloadData()
        }
    }
    // MARK: 세팅 풀다운 버튼
    func settingBarButton(){
        // MARK: 1섹션 3개의 아이템을 정의
        let sortItems = UIMenu(title: "정렬타입", options: .singleSelection, children: [
            UIAction(title: "마감일", handler: { _ in
                self.sortParam = testSortSction.dateSet(ascending: self.sortParam.ascending).parameter
            }),
            UIAction(title: "제목순",state: .on ,handler: { _ in
                self.sortParam = testSortSction.title(ascending: self.sortParam.ascending).parameter
            }),
            UIAction(title: "우선순위순", handler: { _ in
                self.sortParam = testSortSction.onlyprioritySet(ascending: self.sortParam.ascending).parameter
            })
        ])
        // MARK: 2섹션 2개의 아이템 정의
        let sortAt = UIMenu(title: "방식", options: .singleSelection,children: [
            UIAction(title: "오름차순",state: .on ,handler: { _ in
                self.sortParam.ascending = true
            }),
            UIAction(title: "내림차순", handler: { _ in
                self.sortParam.ascending = false
            })
        ])
        guard let baseHomeView = baseHomeView as? DetailHomeView  else {
            return
        }
        // MARK: 사용할 버튼을 가져옵니다.
        let button = baseHomeView.pullDownbutton
        // MARK: 버튼메뉴에 2개의 섹션을 넣습니다.
        button.menu = UIMenu(children: [sortItems, sortAt])
        // MARK: 누르자마자 나오게 합니다.
        button.showsMenuAsPrimaryAction = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
       
    }
    
    
    
//    private func setSortItem(_ section: settingSection){
//        let item = UIAction(title: section.title, handler: section.type(bool: <#T##Bool#>))
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingBarButton()
    }
    
    override func loadView() {
        self.view = baseHomeView
    }
    
    // MARK: 액션 세팅 메서드
    /// 액션을 새팅합니다,
//    private func setupSortAction(for button: UIButton, actions:[(String, ()->Void)] ){
//        
//        button.setTitle("정렬방식", for: .normal)
//        // 상황에 맞는 메뉴 상호 작용이 컨트롤의 기본 작업인지 여부를 결정하는 부울 값입니다.
//        button.showsMenuAsPrimaryAction = true
//        //button.changesSelectionAsPrimaryAction = true
//        
//        let menuItems = actions.map { title, action in
//            UIAction(title: title) { buttonAction in
//                action()
//            }
//        }
//        
//        button.menu = UIMenu(children: menuItems)
//        
//        
//      // MARK: 공식문서
//       //컨트롤이 상황에 맞는 메뉴 상호 작용을 활성화하는지 여부를 결정하는 부울 값입니다.
//        button.isContextMenuInteractionEnabled = true
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
//    }
    
//    func setupSortActionPlus(for button: UIButton, actions: [UIAction]) {
//        
//
//        // MARK: 공식문서
//         //컨트롤이 상황에 맞는 메뉴 상호 작용을 활성화하는지 여부를 결정하는 부울 값입니다.
//        
//        button.menu = UIMenu(children: actions)
//        button.setTitle("정렬방식", for: .normal)
//        button.showsMenuAsPrimaryAction = true
//        button.isContextMenuInteractionEnabled = true
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
//    }
    
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
