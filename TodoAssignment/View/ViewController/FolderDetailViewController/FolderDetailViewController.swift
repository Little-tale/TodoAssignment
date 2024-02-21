//
//  FolderDetailViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/21/24.
//

import UIKit
import SnapKit
import RealmSwift

final class FolderDetailViewController: FolderDetailBaseViewController<DetailHomeView> , allListProtocol{
    /// 버튼: 아이디
    private var modelButtonDic: [UIButton: ObjectId] = [:]
    private let imageManager = SaveImageManager()
    private let fileManager = SaveImageManager()
    // folderResults 참고
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeView.tableView.reloadData()
    }
    
    override func dataSourceAndDelegate() {
        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        
        homeView.tableView.rowHeight = UITableView.automaticDimension
        homeView.tableView.estimatedRowHeight = 100
    }
    
}
extension FolderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        folderResults.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let folderList = folderResults[section]
        return folderList.newTodoTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let folderList = folderResults[indexPath.section].newTodoTable[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseabelIdentifier, for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        print("@@@@",folderList)
        cell.dateLabel.text = folderList.endDay?.description
        cell.folderLabel.text = folderList.folder.first?.folderName
        cell.mainLabel.text = folderList.titleTexts
        cell.subTitleLabel.text = folderList.memoDetail
        cell.priLabel.text = getPrivorityText(number: folderList.priorityNumber)
        
        let image = imageManager.loadImageToDocuments(fileCase: .image, fileNameOfID: "\(folderList.id)")
        
        cell.subImageView.image = image
        cell.imagePrepare(image: image)
       
        print("****",folderList.flagBool)
        cell.leftButton.isSelected = folderList.complite
        cell.leftButton.addTarget(self, action: #selector(toggleOfComplite), for: .touchUpInside)
        modelButtonDic[cell.leftButton] = folderList.id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        
        view.addSubview(label)
        
        label.text = folderResults[section].folderName
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .systemGray
        
        label.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        return view
    }
    // MARK: 테이블뷰 스와이프
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = deleteActionForFolder(indexPath: indexPath)
        let flagAction = flagActionForFolder(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [deleteAction,flagAction])
    }
}
// MARK: 스와이프 액션들
extension FolderDetailViewController {
    func deleteActionForFolder(indexPath: IndexPath) -> UIContextualAction {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, success in
            view.backgroundColor = .blue
            self.deletefolderAction(indexPath: indexPath)
            success(true)
        }
        return delete
    }
    func flagActionForFolder(indexPath: IndexPath) -> UIContextualAction {
        let flagAct = UIContextualAction(style: .normal, title: "깃발") { action, view, success in
            action.backgroundColor = .orange
            self.toggleFlag(index: indexPath)
            success(true)
        }
        flagAct.backgroundColor = .orange
        return flagAct
    }
}

// MARK: 지우기
extension FolderDetailViewController {
    
    func toggleFlag(index: IndexPath) {
        let results = folderResults[index.section].newTodoTable[index.row]
        print("@@",results)
        repository.toggleOf(modle_ID: results.id)
    }
    
    func deletefolderAction(indexPath: IndexPath){
        let data = folderResults[indexPath.section].newTodoTable[indexPath.row]
        fileManager.deleteFileDocuments(fileCase: .image, fileNameID: "\(data.id)")
        repository.removeAt(data)
    }
}
// MARK: @OBJC 펑션
extension FolderDetailViewController {
    
    @objc
    func toggleOfComplite(_ sender: UIButton) {
        print("@@@@@")
        let objectId = modelButtonDic[sender]
        // 아이디가 옵셔널 바인딩이 안되면 에러 띄움
        guard let objectId = objectId else {
            let alert = AlertManager().showAlert(error: RealmErrorCase.cantWriteObject)
            present(alert,animated: true)
            return
        }
        do {
            try repository.compliteUpdater(model_Id: objectId, ButtonBool: sender.isSelected)
        } catch {
            let alert = AlertManager().showAlert(error: error)
            present(alert, animated: true)
        }
    }
    
}
