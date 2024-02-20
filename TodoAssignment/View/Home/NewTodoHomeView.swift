//
//  NewTodoHomeView.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

class NewTodoHomeView: BaseView{
    
    var todoTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func configureHierarchy() {
        self.addSubview(todoTableView)
    }
    override func configureLayout() {
        todoTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    override func register() {
        todoTableView.register(TitleMemoTableCell.self, forCellReuseIdentifier: TitleMemoTableCell.reuseabelIdentifier)
        todoTableView.register(OnlyTitleTableViewCell.self, forCellReuseIdentifier: OnlyTitleTableViewCell.reuseabelIdentifier)
        todoTableView.register(FolderTableCell.self, forCellReuseIdentifier: FolderTableCell.reuseabelIdentifier)
        todoTableView.register(listTableViewCell.self, forCellReuseIdentifier: listTableViewCell.reuseabelIdentifier)
    }
    override func designView() {
        todoTableView.rowHeight = UITableView.automaticDimension
        todoTableView.estimatedRowHeight = 100
    }
}
