//
//  NewListViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/20/24.
//

import Foundation
import UIKit
import RealmSwift

struct NewListViewData {
    var folderName: String
}

class NewListViewController: BaseViewController {
    
    let repository = NewToDoRepository()
    let homeView = DetailHomeView()
    var viewData = NewListViewData(folderName: "")
    
    //MARK: 키보드 자동올려주고 싶은데 애매해서 Flag 방법으로
    var keybordActing = false
    
    override func loadView() {
        view = homeView
    }
    
    var isDone: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.rowHeight = UITableView.automaticDimension
        homeView.tableView.estimatedRowHeight = 80
        navigationSetting()
        keybordActing = true
    }
    
    //MARK: 이게 안끊키긴하는데.... 흠
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = homeView.tableView.cellForRow(at: indexPath) as? DetailListTableViewCell
        cell?.detailListTextField.becomeFirstResponder()
        keybordActing = false
    }
    
    func navigationSetting(){
        let rightButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = rightButton
        
        // MARK: 모달로 보내진 뷰컨만 따로 뒤로가기 다는법
        if presentingViewController != nil {
             
             let leftButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backButtonClicked))
             
             navigationItem.leftBarButtonItem = leftButton
             
             return
        }
        
    }
    @objc
    func backButtonClicked(){
       dismiss(animated: true)
    }
    
    
    // MARK: 세이브 버튼 눌렀을때 동작
    @objc
    func saveButtonClicked(){
        print(repository.realm.configuration.fileURL)
        let folderString = viewData.folderName.trimmingCharacters(in: .whitespaces)
        print(folderString)
        
        if folderString == "" {
            showAlert(title: "이름 필수", message: "이름이 필요합니다.")
            return
        }
        repository.saveNewFolder(folderName: viewData.folderName)
        
        if presentingViewController != nil {
             dismiss(animated: true)
            isDone?()
             return
        }
        navigationController?.popViewController(animated: true)
        
    }
}

extension NewListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailListCellCase.allCases.count - 1 // MARK: 이미지 구현 남김
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = DetailListCellCase.allCases[indexPath.section]
        switch section {
        case .listMain:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailListTableViewCell.reuseabelIdentifier, for: indexPath) as? DetailListTableViewCell else {
                print("**DetailListTableViewCell")
                return UITableViewCell()
            }
            cell.textFieldDelegate = self
            return cell
        case .listCase:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OnlyTitleTableViewCell.reuseabelIdentifier, for: indexPath) as? OnlyTitleTableViewCell else {
                print("**OnlyTitleTableViewCell")
                return UITableViewCell()
            }
            
            return cell
        case .ColorCase:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailListTableViewCell.reuseabelIdentifier, for: indexPath) as? DetailListTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

//MARK: 텍스트 필드 Protocol로 역값전달
extension NewListViewController: DetailTextFieldProtocol {
    func textFieldDidChanged(for textField: UITextField) {
        viewData.folderName = textField.text ?? ""
        print(textField.text)
    }
}

// MARK: 이렇게 하면 키보드가 나오면서 두두두둗두두두두 함 매우 기분이 나쁨
//            if keybordActing == true {
//                print("******ssss")
//                cell.detailListTextField.becomeFirstResponder()
//            }
//            keybordActing = false
//    // MARK: 처음 화면이 로드 될때만 키보드를 올리는 방법 -> 여전히 두둑 끊김
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let section = DetailListCellCase.allCases[indexPath.section]
//        if section == .listMain {
//            guard let cell = cell as? DetailListTableViewCell else {
//                print(cell)
//                return
//            }
//
//            if keybordActing == true {
//                print("******",#function)
//                cell.detailListTextField.becomeFirstResponder()
//                keybordActing.toggle()
//            }
//
//        }
//
//    }
/* // wiiDisplay에서 셀 재사용 할게 아니라 이 밑에 코드는 작동이 안됨
 //            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailListTableViewCell.reuseabelIdentifier, for: indexPath) as? DetailListTableViewCell else {
 //                print("섹션 에러 문제 willDisplay")
 */
