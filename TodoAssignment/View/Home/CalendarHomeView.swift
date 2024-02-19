//
//  CalendarHomeView.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/19/24.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarHomeView: BaseView{
    
    let calendar = FSCalendar(frame: .zero)
    let tableView = UITableView(frame: .zero)
    var heightConstratits: Constraint?
    let upgesture = UISwipeGestureRecognizer()
    let downGesture = UISwipeGestureRecognizer()
    
    override func configureHierarchy() {
        self.addSubview(calendar)
        self.addSubview(tableView)
        
    }
    override func configureLayout() {
        //MARK: Constraints를 외부로 빼서 참조가 가능하다고함
        calendar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            // make.height.equalTo(300)
            self.heightConstratits = make.height.equalTo(300).constraint
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(calendar.snp.bottom)
        }
    }
    override func designView() {
        designFSCalendar()
    }
    
    override func register() {
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseabelIdentifier)
        
    }
    
    
    private func designFSCalendar(){
        calendar.scrollDirection = .horizontal
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.scope = .month

        
        upgesture.addTarget(self, action: #selector(upAction))
        downGesture.addTarget(self, action: #selector(downAction))
        
        upgesture.direction = .up
        downGesture.direction = .down
        
        calendar.addGestureRecognizer(upgesture)
        calendar.addGestureRecognizer(downGesture)
    }
    
    
    @objc
    func upAction(){
        heightContol(height: 150)
        calendar.scope = .week
    }
    @objc
    func downAction(){
        heightContol(height: 300)
        calendar.scope = .month
    }
    
    func heightContol(height: CGFloat){
        heightConstratits?.update(offset: height)
    }
    
    
    
}
