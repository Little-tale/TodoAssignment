//
//  FolderDetailViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/21/24.
//

import UIKit
import SnapKit
import RealmSwift

class FolderDetailViewController: FolderDetailBaseViewController<DetailHomeView> {
    /// 버튼: 아이디
    var modelButtonDic: [UIButton: ObjectId] = [:]
    let imageManager = SaveImageManager()
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
        cell.dateLabel.text = folderList.endDay?.description
        cell.folderLabel.text = folderList.folder.first?.folderName
        cell.mainLabel.text = folderList.titleTexts
        cell.subTitleLabel.text = folderList.memoTexts
        cell.priLabel.text = folderList.priorityNumber.description
        cell.subImageView.image = imageManager.loadImageToDocuments(fileCase: .image, fileNameOfID: "\(folderList.id)")
        
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
    
}
