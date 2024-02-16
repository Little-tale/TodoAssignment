//
//  TagSettingViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

final class TagSettingViewController: BaseViewController {
    
    let textField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    var tagData: String = ""
    
    // var getTagDatas: ((String)-> Void)?
    
    
    override func configureHierarchy() {
        self.view.addSubview(textField)
       
    }
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(34)
        }
    }
    override func designView() {
        textField.placeholder = "각종 태그를 입력해 보세요 \",\" 으로 구분해 드립니다!"
        textField.addTarget(self, action: #selector(getTagData), for: .editingDidEndOnExit)
    }
    
    // MARK: , 기준으로 분리해 드립니다.
    private func divideText(text: String) -> [String]{
        let textArray = text.components(separatedBy: ",")
        // 분리완료
        print(textArray)
        return textArray
    }
    
    // MARK: 문자열배열을 주시면 #을 단 문자열로 돌려드립니다. -> MAP 리듀스
    ///  [abc,bd,ceq,das,ecv] -> #abc, #bd, #ceq, #das, #ecv
    private func addSHAP(stringArray: [String]) -> String{
        let SHAPArray = stringArray.map { value in
            "#"+value
        }
        // print(SHAPArray)
        let result = SHAPArray.joined(separator: ", ")
        return result
    }
    
    @objc
    func getTagData(sender : UITextField){
        // print(sender.text)
        guard let searchText = sender.text else {
            return
        }
        tagData = addSHAP(stringArray:divideText(text: searchText))
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // MARK: 쉬는시간 확인
        guard tagData != "" else {
            return
        }
        // getTagDatas?(tagData)
        print(tagData)
        NotificationCenter.default.post(name: NSNotification.Name("tagData"), object: self, userInfo: ["tag":tagData])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
        
    }
}



/*
 NotificationCenter.default.addObserver(self, selector: #selector(getTagData), name: NSNotification.Name("tagData") , object: nil)
 navigationController?.pushViewController(vc, animated: true)
 */
