//
//  AllListHomView.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

final class AllListHomeView: BaseView {
    
    var whereGoToView: (() -> Void)?
    var goToListViewM: (() -> Void)?
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    
    lazy var leftButton: UIBarButtonItem = {
        let view = UIButton(type: .contactAdd )
        view.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        view.setTitle("새로운 할일", for: .normal)
        view.titleLabel?.textColor = .black
        view.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        view.addTarget(self, action: #selector(goToNewToDoView), for: .touchUpInside)
        // view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        // view.sizeToFit()
        return UIBarButtonItem(customView: view)
    }()
    
    lazy var rightButton : UIBarButtonItem = {
        let view = UIButton(type: .system )
        view.setTitle("목록추가", for: .normal)
        view.addTarget(self, action: #selector(goToListView), for: .touchUpInside)
        view.titleLabel?.textColor = .blue
        view.imageView?.image = nil
        return UIBarButtonItem(customView: view)
    }()
    
    @objc
    func goToListView(){
        goToListViewM?()
    }
    
    lazy var spacerButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

    
    lazy var buttonArray = [leftButton, spacerButton, rightButton ]
    
    override func configureHierarchy() {
        self.addSubview(tableView)
    }
    
    
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    override func designView() {
        leftButton.customView?.sizeToFit()
    }
    
    
    @objc
    func goToNewToDoView(){
        whereGoToView?()
    }
    
    override func register() {
        tableView.register(listTableViewCell.self, forCellReuseIdentifier: listTableViewCell.reuseabelIdentifier)
        
        tableView.register(AllListTableInCollectionCell.self, forCellReuseIdentifier: AllListTableInCollectionCell.reuseabelIdentifier)
    }

}
