//
//  CalendarViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/19/24.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: BaseHomeViewController<CalendarHomeView> {
    
    let repository = NewToDoRepository()
    lazy var allList = repository.CalendarFilter(date: Date()){didSet{homeView.tableView.reloadData()}}
    let fileManager = SaveImageManager()
    var modelButtonDictionary: [UIButton: ObjectId] = [:]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationSetting()
        dataSourceAndDelegate()
        
    }
    func navigationSetting(){
        navigationItem.title = "캘린더"
    }
    override func dataSourceAndDelegate() {
        homeView.calendar.delegate = self
        homeView.calendar.dataSource = self
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
    }
    
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        allList = repository.CalendarFilter(date: date)
        
        print(date)
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        guard let data = repository.CalendarFilter(date: date) else {
            print("datㅌ  처리실패")
            return 0
        }
        if data.count > 3 {
            return 3
        }
        return data.count
    }
}

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseabelIdentifier, for: indexPath) as? DetailTableViewCell else {
            print("셀 레지스터 문제")
            return UITableViewCell()
        }
        
        guard let allList = allList?[indexPath.row] else {
            print("데이터 없는 문제")
            return UITableViewCell()
        }
        cellDataSetting(for: cell, modelData: allList)
        return cell
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
    }
}


extension CalendarViewController {
    func cellDataSetting(for cell: DetailTableViewCell, modelData: NewToDoTable){
        
        let date = DateAssistance().getDate(date: modelData.endDay)
        let prioritynum = modelData.priorityNumber
        
        cell.mainLabel.text = modelData.titleTexts
        cell.dateLabel.text = date
        cell.tagLabel.text = modelData.tagText
        cell.priLabel.text = getPrivorityText(number: prioritynum)
        cell.subTitleLabel.text = modelData.memoTexts
        cell.leftButton.isSelected = modelData.complite
        cell.leftButton.addTarget(self, action: #selector(toggleOfComplite), for: .touchUpInside)
        cell.folderLabel.text = modelData.folder.first?.folderName
        
        if let image = fileManager.loadImageToDocuments(fileCase: .image, fileNameOfID: "\(modelData.id)") {
            print("*****",image,modelData.id)
            cell.subImageView.image = image
            print("*****")
        }
        
        modelButtonDictionary[cell.leftButton] = modelData.id
    }
    
    @objc
    func toggleOfComplite(_ sender: UIButton) {

        print(modelButtonDictionary[sender] ?? "")
        // 버튼 선택상태를 -> 컴플리트 상태값으로
        print(sender.isSelected)
        
        let objectId = modelButtonDictionary[sender]
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
    func getPrivorityText(number: Int) -> String{
        prioritization.allCases[number].exclamationMark
    }
}
