//
//  NewTodoHomeView.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

final class NewTodoHomeView: BaseView{
    
    let todoTableView = UITableView(frame: .zero, style: .insetGrouped)
    
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
    }
    override func designView() {
        todoTableView.rowHeight = UITableView.automaticDimension
        todoTableView.estimatedRowHeight = 100
    }
}
