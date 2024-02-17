//
//  NewTodoViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import RealmSwift

class NewTodoViewController: BaseViewController {
    let newtodoHomeView = NewTodoHomeView()
    
    var titleText: String?
    var memoText: String?
    
    var dateInfo: Date?
    var tagInfo: String?
    var flagBool: Bool?
    
    var prioritizationIndex = 0 { didSet{ newtodoHomeView.todoTableView.reloadData() } }
    
    let toDoReomsitory = NewToDoRepository()
    
    
    
    // var dataBox: [Int:]
    // MARK: 값 변화 감지 못함... 인스턴스가 교체되는 방식이 아니라 그럼
    var list: Results<NewToDoTable>! {
        didSet{
            print("adsadsadsada")
            newtodoHomeView.todoTableView.reloadData()
        }
    }
    
   
    
    override func loadView() {
        self.view = newtodoHomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleagateDatasoure()
        self.view.backgroundColor = .white
        navigationItem.title = "새로운 할일"
        settingNavigation()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = true
        
        // checSaveButton()
    }
    
    // MARK: 검사 로직 -> 연습해보기
//    func checSaveButton(){
//        guard let text = titleText else {
//            navigationItem.rightBarButtonItem?.isEnabled = false
//            return
//        }
//        guard text != "" else {
//            navigationItem.rightBarButtonItem?.isEnabled = false
//            return
//        }
//        navigationItem.rightBarButtonItem?.isEnabled = true
//    }
    
    func deleagateDatasoure(){
        newtodoHomeView.todoTableView.delegate = self
        newtodoHomeView.todoTableView.dataSource = self
    }
    func settingNavigation(){
        let rightButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonCliecked))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc
    func saveButtonCliecked(){
        
        guard let titleText = titleText else {
            showAlert(title: "No Title", message: "타이틀은 필수입니다!")
            return
        }
        let text = titleText.trimmingCharacters(in: .whitespaces)
       
        if text == "" {
            showAlert(title: "No Title", message: "타이틀은 필수입니다!")
            return
        }
       
        let newToDoRecord = NewToDoTable(title: titleText, memoTexts: memoText, endDay: dateInfo, tagText: tagInfo, priorityNumber: prioritizationIndex, flagBool: flagBool ?? false)
        
        toDoReomsitory.createOfRecord(object: newToDoRecord)
        
        navigationController?.popViewController(animated: true)
    }

}



extension NewTodoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return NewToDoList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = NewToDoList.allCases[indexPath.section]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnlyTitleTableViewCell.reuseabelIdentifier, for: indexPath) as? OnlyTitleTableViewCell else {
            print("TitleMemoTableCell 아이덴티 이슈")
            return UITableViewCell()
            
        }
        
        cell.backgroundColor = .systemGray
        cell.titleLabel.text = section.getTile
        
        switch section{
        case .memo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleMemoTableCell.reuseabelIdentifier, for: indexPath) as? TitleMemoTableCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        case .endDay:
            cell.infoLabel.text =  DateAssistance().getDate(date: self.dateInfo) 
            return cell
            
        case .tag:

            cell.infoLabel.text = self.tagInfo
            return cell
        case .prioritization:
            cell.infoLabel.text = prioritization.allCases[prioritizationIndex].name
        case .addImage:
            break
        case .flag:
            cell.obserVerToggle(imageHiddenBool: true)
            cell.switchToggleAction = {
                controll in
                self.switchButton(control: controll)
            }
            break
        }
        
        return cell
    }
    // MARK: 스위치 버튼 액션
    func switchButton(control: UISwitch){
        // print(control.isOn)
        flagBool = control.isOn
    }

    
    // MARK: 헤더 푸터 크기 줄여서 여백 죽이기
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 14
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    // MARK: 셀을 선택했을때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secction = NewToDoList.allCases[indexPath.section]
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch secction{
        case .memo:
            return
        case .endDay:
            // MARK: 클로저 캡처를 이용한 역값전달
            let vc = DatePickerViewController()
            
            vc.date = self.dateInfo
            
            vc.DateInfo = {
                result in
                // print(result)
                self.dateInfo = result
                self.newtodoHomeView.todoTableView.reloadData()
            }
            
            navigationController?.pushViewController(vc, animated: true)
        case .tag:
            let vc = TagSettingViewController()
            NotificationCenter.default.addObserver(self, selector: #selector(getTagData), name: NSNotification.Name("tagData") , object: nil)
            
            let data = self.tagInfo
            navigationController?.pushViewController(vc, animated: true)
            
            guard let data = data else {
                return
            }
            print("🦉🦉🦉🦉🦉🦉",data) //MARK: 생각해보기
            vc.tagData = data
            return
            
        case .prioritization:
            let vc = PrioritizationViewController()
            vc.prioritizationDelegate = self
            vc.segmentIndex = self.prioritizationIndex
            navigationController?.pushViewController(vc, animated: true)
            return
            
        case .addImage:
            return
            
        case .flag:
            return
        }
        
    }
    
    // MARK: 메모리 누수 방지를 위한 대처
//    override func viewDidDisappear(_ animated: Bool) {
//
//    }
    
    @objc
    func getTagData(sender: Notification){
        // print(sender.userInfo?["tag"])
        // print(sender.userInfo?["tag"] as String)
        if let value = sender.userInfo?["tag"] as? String {
            print("🐷🐷🐷🐷🐷🐷",value)
            tagInfo = value
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "tagData"), object: nil)
        
        self.newtodoHomeView.todoTableView.reloadData()
    }
    
    
}

extension NewTodoViewController: selectedPrioritization {
    func getPrioritization(for AllViewContoller: UIViewController, prioitiNum: Int) {
        print(prioritization.allCases[prioitiNum].name)
        
        self.prioritizationIndex = prioritization.allCases[prioitiNum].rawValue
        
    }
}



extension NewTodoViewController: TitleMemoTextFieldProtocol {
    
    func textFieldDidChanged(for cell: TitleMemoTableCell, title: String?, Info: String?) {
        self.titleText = title
        self.memoText = Info
        // checSaveButton()
    }
    
    
}


/*
 // let date = DateAssistance().getOnlyDate(date: dateInfo)
 // print(date, "asdsadasdasad")
 
 // 2.2 클래스에 넣어줄 데이터(레코드!)를 구성합니다
 */
