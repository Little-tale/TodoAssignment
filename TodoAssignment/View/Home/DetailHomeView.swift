//
//  DetailHomeView.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/15/24.
//

import UIKit
import SnapKit

final class DetailHomeView: BaseView{
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    lazy var pullDownbutton: UIButton = {
        let button = UIButton(type: .system)
        //button.frame = .init(x: 0, y: 0, width: 100, height: 40)
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.tintColor = .blue
        button.sizeToFit()
        return button
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
        
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseabelIdentifier)
        tableView.register(DetailListTableViewCell.self, forCellReuseIdentifier: DetailListTableViewCell.reuseabelIdentifier)
        tableView.register(OnlyTitleTableViewCell.self, forCellReuseIdentifier: OnlyTitleTableViewCell.reuseabelIdentifier)
    }
    override func designView() {
        self.backgroundColor = .white
        
    }
    
    
}


