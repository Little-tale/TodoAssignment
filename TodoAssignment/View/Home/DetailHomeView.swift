//
//  DetailHomeView.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/15/24.
//

import UIKit
import SnapKit

class DetailHomeView: BaseView{
    let tableView = UITableView(frame: .zero)
    lazy var pullDownbutton: UIButton = {
        let button = UIButton(type: .system)
       
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.tintColor = .blue
        return button
    }()
    
    lazy var menuItems: [UIAction] = {
        return[
            UIAction(title: "마감일순으로 보기", handler: { _ in
                print("Test")
            })
        ]
    }()
    
    override func configureHierarchy() {
        self.addSubview(tableView)
    }
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

    override func register() {
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseabelIdentifier)
        
    }
    override func designView() {
        self.backgroundColor = .white
        
    }
    
    
}
