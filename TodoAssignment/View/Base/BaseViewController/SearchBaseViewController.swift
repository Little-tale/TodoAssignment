//
//  SearchBaseViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/17/24.
//

import UIKit
// import RealmSwift

/*
 다른 뷰 컨트롤러의 콘텐츠에 대한 표준 검색 경험을 제공하려면 검색 컨트롤러를 사용하세요. 사용자가 와 상호작용할 때 검색 컨트롤러는 검색 결과 컨트롤러와 협력하여 검색 결과를 표시합니다.UISearchBar

 iOS에서는 검색 컨트롤러를 자신의 뷰 컨트롤러 인터페이스에 통합하세요. 앱에 적합한 방식으로 뷰 컨트롤러를 표시하세요. 앱에서 검색 컨트롤러를 구현하는 방법을 알아보려면 검색 컨트롤러를 사용하여 검색 가능한 콘텐츠 표시 및 검색 컨트롤러와 함께 추천 검색 사용을 참조하세요 .searchBar

 */
class SearchBaseViewController: BaseViewController {
    //MARK: 뷰컨트롤러의 뷰가 메모리에 로드된 후 호출되는 생명주기
    //즉 이시점에 UI구성요소를 초기화 하고 설정하는것이 좋다.
    
    let resultsViewController = DetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsViewController.settingViewDataInfomation(whatInfo: .all)
        // 서치 컨트롤러는 뷰디드로드 메서드 내에 위치하는것이 좋다.
        let searchContoller = UISearchController(searchResultsController: resultsViewController)
        
        // 서치 결과 업데이터 프로토콜을 구현할 객체님을 내가 함.
        searchContoller.searchResultsUpdater = self
        
        // false 일때 검색하기전에 뷰를 흐리게 표시하지 말라는 메서드
        searchContoller.obscuresBackgroundDuringPresentation = true
        
        searchContoller.searchBar.placeholder = "검색해보시오"
        
        // 뷰컨틀롤러의 네비 아이템에 검색 컨트롤러를 이걸 쓰라고 지정
        navigationItem.searchController = searchContoller
        
        navigationSetting()
    }
    
    private func navigationSetting(){
        // navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "검색창"

        navigationItem.largeTitleDisplayMode = .always
        
        navigationController?.navigationBar.tintColor = .gray
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.systemGray]
        
        // 현재 뷰 컨트롤러를 검색 컨트롤러가 활성화일때 정의하는 뷰컨으로 설정하는 메서드
        // definesPresentationContext = false
    }
    
}


/*
 검색 컨트롤러의 속성에 개체를 제공합니다 . 일반적으로 검색 가능한 콘텐츠가 있는 뷰 컨트롤러는 검색 결과 업데이트 개체 역할도 하지만 원하는 경우 다른 개체를 사용할 수 있습니다. 사용자가 검색창과 상호작용하면 검색 컨트롤러는 적절한 메서드를 호출하여 개체에 검색을 수행하고 검색 결과 보기의 콘텐츠를 업데이트할 수 있는 기회를 제공합니다
 */
extension SearchBaseViewController: UISearchResultsUpdating {
    // 이메서드는 값이 변할때마다 반복되는 메서드다.
    func updateSearchResults(for searchController: UISearchController) {
        // print(searchController.searchBar.text)
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        // MARK: 해당뷰를 재사용해서 검색해봐야 할것 같은데
        
        // resultsViewController.repository.
        let data = resultsViewController.repository.DetailFilterOfText(of: searchText)
        //print(data,"*****")
        resultsViewController.settingViewDataSearchCase(data: data)
        
        print(#function)
    }
    
}
