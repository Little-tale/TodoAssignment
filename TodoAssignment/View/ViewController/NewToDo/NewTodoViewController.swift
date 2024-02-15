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
    
    var dateInfo: Date? {
        didSet{
            newtodoHomeView.todoTableView.reloadData()
        }
    }
    var tagInfo: String? {
        didSet{
            newtodoHomeView.todoTableView.reloadData()
        }
    }
    var prioritizationIndex = 0 {
        didSet{
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
        
    }
    
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
        // MARK: UserDefaults 로 했었을때 저장 시점
//        let data = TodoList(title: titleText, memo: self.memoText ?? "", lastDate: self.dateInfo, tag: self.tafInfo, privority: self.prioritizationIndex)
//        
//        UserDefaultsManager.shared.appendData(data)
        // MARK: Realm 궁전을 통해 저장 시점
        
        // 1. 값을 넣어줄 구조체를 생성합니다
        do{
            let saveRealm = try Realm()
            // 2. 클래스 init을 통해 값을 넣어 줍니다.
                // 2.1 해당 테이블이 어디에 있는지 찾아봅니다.
            print(saveRealm.configuration.fileURL ?? "테이블 경로를 못찾음")
            
            let date = DateAssistance().getOnlyDate(date: dateInfo)
            print(date, "asdsadasdasad")
            
            // 2.2 클래스에 넣어줄 데이터(레코드!)를 구성합니다.
            let newToDoRecord = NewToDoTable(title: titleText, memoTexts: memoText, endDay: dateInfo, tagText: tagInfo, priorityNumber: prioritizationIndex, onlyDate: date)
            
            // 3. 해당 데이터를 Realm 데이터 베이스에 저장합니다.
            do {
                try saveRealm.write {
                    saveRealm.add(newToDoRecord)
                    showAlert(title: "저장 성공", message: "")
                }
            } catch {
                showAlert(title: "값을 저장하지 못했어요", message: "앱을 삭제하고 재시도 하세요!")
            }
            
        } catch {
            showAlert(title: "테이블 에러!()", message: "앱을 삭제하고 재시도 하세요!")
        }
        
    
        
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
        switch section{
        case .memo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleMemoTableCell.reuseabelIdentifier, for: indexPath) as? TitleMemoTableCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            
            return cell
        case .endDay:
            cell.titleLabel.text = section.getTile
            cell.infoLabel.text =  DateAssistance().getDate(date: self.dateInfo) 
            return cell
            
        case .tag:
            cell.titleLabel.text = section.getTile
            print("🙊🙊🙊🙊🙊",self.tagInfo)
            cell.infoLabel.text = self.tagInfo
            return cell
        case .prioritization:
            cell.titleLabel.text = section.getTile
            cell.infoLabel.text = prioritization.allCases[prioritizationIndex].name
        case .addImage:
            cell.titleLabel.text = section.getTile
        }
        
        return cell
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
        
    }
    
}

extension NewTodoViewController: selectedPrioritization {
    func getPrioritization(for AllViewContoller: UIViewController, prioitiNum: Int) {
        print(prioritization.allCases[prioitiNum].name)
        self.prioritizationIndex = prioritization.allCases[prioitiNum].rawValue
    }
}



extension NewTodoViewController: TitleMemoTextFieldProtocol {
    func textFieldDidEndEditing(for cell: TitleMemoTableCell, title: String?, Info: String?) {
        self.titleText = title
        self.memoText = Info
    }
}
