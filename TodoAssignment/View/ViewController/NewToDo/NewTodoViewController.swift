//
//  NewTodoViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import RealmSwift

// MARK: 텍스트 필드가 현재 두개로 구현했는데 1개로 바꾸고 하나는 텍스트 뷰로 수정하자 -> OK

// MARK: 데이터가 5개 따로 변수를 받고 있는데 하나로 해결해 볼수 있는 방법을 고민해 보자

struct NewToDoItem {
    var titleText: String? // 타이틀
    var memoText: String? // 메모
    var dateInfo: Date? // 날짜
    var tagInfo: String? // 태그
    var flagBool: Bool // 깃발 기본은 False 로 할 예정
    var prioritizationIndex: Int // 우선순위인덱스 기본은 0일 예정
    var profileImage: UIImage?
}

class NewTodoViewController: BaseViewController {
    let newtodoHomeView = NewTodoHomeView()
    
    let alertManager = AlertManager()
    
    // MARK: 하나의 구조체 관리 // 하나로 묶어서 관리하려 했으나 타이틀, 메모 텍스트는 변화할때는 리로드가 필요가 없는데 지금 리로드 되고 있다.
    var newToDoItem = NewToDoItem(flagBool: false, prioritizationIndex: 0) 
//    {
//        didSet{
//            newtodoHomeView.todoTableView.reloadData()
//        }
//    }
    
//    var titleText: String?
//    var memoText: String?
//    
//    var dateInfo: Date?
//    var tagInfo: String?
//    var flagBool: Bool?
//    
    // 이런 다른 데이터들을 하나로 관리할수 있는방법 연구해보기
    
//    var prioritizationIndex = 0 { didSet{ newtodoHomeView.todoTableView.reloadData() } }
    
    let toDoReomsitory = NewToDoRepository()
    let saveImageFileManager = SaveImageManager()
    
    
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
    
    // MARK: 저장버튼 눌렀을때
    @objc
    func saveButtonCliecked(){
        let data = newToDoItem
        guard let titleText = data.titleText else {
            showAlert(title: "No Title", message: "타이틀은 필수입니다!")
            return
        }
        let text = titleText.trimmingCharacters(in: .whitespaces)
       
        if text == "" {
            showAlert(title: "No Title", message: "타이틀은 필수입니다!")
            return
        }
       
        let newToDoRecord = NewToDoTable(title: text, memoTexts: data.memoText, endDay: data.dateInfo, tagText: data.tagInfo, priorityNumber: data.prioritizationIndex, flagBool: data.flagBool)
        
        toDoReomsitory.createOfRecord(object: newToDoRecord)
        
        // MARK: 사진 저장하는 시점
        if let image = newToDoItem.profileImage {
            saveImageFileManager.saveImageToDocument(image: image, filename: "\(newToDoRecord.id)")
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
        cell.titleLabel.text = section.getTile
        
        switch section{
        case .memo:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleMemoTableCell.reuseabelIdentifier, for: indexPath) as? TitleMemoTableCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.textViewDelegate = self
            return cell
        case .endDay:
            
            cell.infoLabel.text =  DateAssistance().getDate(date: newToDoItem.dateInfo)
            return cell
            
        case .tag:
            
            cell.infoLabel.text = newToDoItem.tagInfo
            return cell
        case .prioritization:
            
            cell.infoLabel.text = prioritization.allCases[newToDoItem.prioritizationIndex].name
        case .addImage:
            
            cell.prepareForCell(profileImage: true)
            cell.profileImageView.image = newToDoItem.profileImage
            break
        case .flag: // MARK: 클로저가 강하게 self를 참조하면 ARC가 인스턴스를 메모리에서 해제 잘 못함
            cell.prepareForCell(switchButton: true)
            cell.switchToggleAction = {
                [weak self] control in
                self?.switchButton(control: control)
            }
            break
        }
        
        return cell
    }
    // MARK: 스위치 버튼 액션
    func switchButton(control: UISwitch){
        newToDoItem.flagBool = control.isOn
    }

    
    // MARK: 헤더 푸터 크기 줄여서 여백 죽이기
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
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
            
            vc.date = newToDoItem.dateInfo
            
            vc.DateInfo = {
                [weak self] result in
                // print(result)
                self?.newToDoItem.dateInfo = result
                self?.reloadTableViewSection(for: secction)
            }
            
            navigationController?.pushViewController(vc, animated: true)
        case .tag:
            let vc = TagSettingViewController()
            NotificationCenter.default.addObserver(self, selector: #selector(getTagData), name: NSNotification.Name("tagData") , object: nil)
            
            let data = newToDoItem.tagInfo
            
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
            vc.segmentIndex = newToDoItem.prioritizationIndex
           
            navigationController?.pushViewController(vc, animated: true)
            return
            
        case .addImage:
            let alert = alertManager.settingActionSheet(title: "이미지가져오기", actions: settingActions())
            present(alert,animated: true)
            return
            
        case .flag:
            return
        }
        
    }

    // MARK: 노티피케이션 방법을 통한 역 값전달.
    @objc
    func getTagData(sender: Notification){
    
        if let value = sender.userInfo?["tag"] as? String {
            print("🐷🐷🐷🐷🐷🐷",value)
            newToDoItem.tagInfo = value
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "tagData"), object: nil)
        reloadTableViewSection(for: .tag)
    }
    
    // MARK: 액션 넣어주기 Test 버전 -> 1차 실패 강함참조로 인해 보임 -> 2차 성공
    // 1차 실패시 클로저에서 즉시 실행해 버려서 액션 시트가 나오지 않음
    // 2차시에는 바로 액션으로 변환하는 대신 약한 참조로 바로 액션이 나오게 하는것을 방지
    func settingActions() -> [UIAlertAction] {
        let actions = addImageSection.allCases.map { section -> UIAlertAction in
            alertManager.actionSetting(title: section.title) {
                [weak self] in
                section.imageAction(from: self!)
            }
        }
        return actions
    }
    
}
// MARK: 딜리게이트 패턴일수도 있는 프로토콜 방법인데 둘의 차이는 잘 와 닿지는 않는것 같다.
extension NewTodoViewController: selectedPrioritization {
    func getPrioritization(for AllViewContoller: UIViewController, prioitiNum: Int) {
        print(prioritization.allCases[prioitiNum].name)
        
        newToDoItem.prioritizationIndex = prioritization.allCases[prioitiNum].rawValue
       
        reloadTableViewSection(for: .prioritization)
    }
}

extension NewTodoViewController: TitleTextFieldProtocol {
    
    func textFieldDidChanged(for cell: TitleMemoTableCell, title: String?) {
        newToDoItem.titleText = title
        // checSaveButton()
    }
    
}
// MARK: 현재 값을 제한하여 길이 제한하는거 고민해야함 https://fomaios.tistory.com/entry/iOS-%ED%85%8C%EC%9D%B4%EB%B8%94%EB%B7%B0-%EC%95%88%EC%97%90-%EC%9E%88%EB%8A%94-%ED%85%8D%EC%8A%A4%ED%8A%B8%EB%B7%B0-%EB%86%92%EC%9D%B4-%EA%B8%80%EC%97%90-%EB%94%B0%EB%9D%BC-%EC%A1%B0%EC%A0%95%ED%95%98%EA%B8%B0Dynamic-tableviewcell-height-by-textview-text
extension NewTodoViewController: MemoTextViewProtocol {
    func textViewDidChange(_ textView: UITextView) {
        newToDoItem.memoText = textView.text
  
        let size = textView.bounds.size
        let newSize = newtodoHomeView.todoTableView.sizeThatFits(CGSize(width: size.width,
                                                                        height: CGFloat.greatestFiniteMagnitude))
        
        if size.height != newSize.height {
            // IOS 11 이상 권장사항
            if #available(iOS 11, *) {
                newtodoHomeView.todoTableView.performBatchUpdates(nil)
            } else {
                UIView.setAnimationsEnabled(false)
                newtodoHomeView.todoTableView.beginUpdates()
                newtodoHomeView.todoTableView.endUpdates()
                UIView.setAnimationsEnabled(true)
            }
        }
        
    }
    
}
// MARK: 이미지 피커컨 딜리게이트 네비컨 딜리게이트
extension NewTodoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: 취소 버튼을 눌렀을때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        
        
        dismiss(animated: true)
    }
    // 이미지를 눌렀을때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        // imagePickerController(_:didFinishPickingMediaWithInfo:) 출력됨
        //print(picker)
        
        // *** [__C.UIImagePickerControllerInfoKey(_rawValue: ......
        //print("***",info) // 이미지의 정보가 출력됨
        
        // MARK: 원본 이미지를 가져오기
//        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] {
//            
//            print(selectedImage)
//        }
        // MARK: 거의 정사각형으로(가끔아님) 편집된 사진 가져오기
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            // as? UIImage로 형변환 시도후 성공시
            print(selectedImage)
            
            newToDoItem.profileImage = selectedImage
            reloadTableViewSection(for: .addImage)
        }
        
        
        dismiss(animated: true)
    }
}

// MARK: 특정 섹션만 리로드 하는 방법을 알아보기.
extension NewTodoViewController{
    
    private func reloadTableViewSection(for section: NewToDoList) {
        // 섹션 해당하는 인덱스 가져오기
        guard let section = NewToDoList.allCases.firstIndex(of: section) else {
            return
        }
        // MARK: IndexSet은 하나의 범위로 인덱스를 관리하여 메모리 사용량을 죄적화 하여 준다.!
        // MARK: 심지어 불연속적 0,4,12 같은 인덱스 집합도 표현이 가능하다!
        let tableIndex =  IndexSet(integer: section)
        
        newtodoHomeView.todoTableView.reloadSections(tableIndex, with: .automatic)
        
        
        // MARK: 특정 로우를 리로드 하는 방법도 존재한다.
//        newtodoHomeView.todoTableView.reloadRows(at: <#T##[IndexPath]#>, with: <#T##UITableView.RowAnimation#>)
    }
}

/*
 // print(textView.text)
 
//        let tableViewcell = newtodoHomeView.todoTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.bounds.height
//        print(tableViewcell)
 */

/*
 // let date = DateAssistance().getOnlyDate(date: dateInfo)
 // print(date, "asdsadasdasad")
 
 // 2.2 클래스에 넣어줄 데이터(레코드!)를 구성합니다
 */
