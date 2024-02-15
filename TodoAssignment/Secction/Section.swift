//
//  Section.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import RealmSwift
// MARK: 잭님이 주신 과제의 원본 섹션

enum NewToDoList: CaseIterable {
    case memo
    case endDay
    case tag
    case prioritization
    case addImage
    
    var getTile : String {
        switch self {
        case .endDay:
            return "마감일"
        case .tag:
            return "태그"
        case .prioritization:
            return "우선순위"
        case .addImage:
            return "이미지 추가"
        default: return ""
        }
    }
    
    /// 불명확 type, 존재  type
    /// coordinator, 라우터 --> 일단 다음에 시도하는 걸로
    var nextView: UIViewController? {
        switch self {
        case .memo:
            nil
        case .endDay:
            DatePickerViewController()
        case .tag:
            nil
        case .prioritization:
            nil
        case .addImage:
            nil
        }
    }
}




enum AllListCellCase: CaseIterable {
    case today
    case upcoming
    case all
    case flag
    case completed
    
    var name: String {
        switch self {
        case .today:
            "오늘"
        case .upcoming:
            "예정"
        case .all:
            "전체"
        case .flag:
            "깃발표시"
        case .completed:
            "완료됨"
        }
    }
    
    var imageName: String {
        switch self {
        case .today:
            "calendar.circle.fill"
        case .upcoming:
            "calendar.circle.fill"
        case .all:
            "archivebox.circle"
        case .flag:
            "flag.circle.fill"
        case .completed:
            "checkmark.circle.fill"
        }
    }
    
    var backColor: UIColor {
        switch self {
        case .today:
            UIColor.systemBlue
        case .upcoming:
            UIColor.systemRed
        case .all:
            UIColor.systemGray
        case .flag:
            UIColor.systemYellow
        case .completed:
            UIColor.systemGray5
        }
    }
    
    var howMany: Int {
        // MARK: Realm 값 불러오는 시점
        // 1. 값을 가져올 구조체를 생성합니다.
        let loadRealm = try! Realm()
        let model = NewToDoTable.self
        switch self {
        case .today:
            let date = DateAssistance().getOnlyDate(date: Date())
            guard let dates = date else {
                return 0
            }
            let loadObject = loadRealm.objects(model).where { result in
                result.onlyDate == dates
            }
            print(loadObject.count, dates)
            return loadObject.count
        case .upcoming:
            //MARK: 쿼리 언어를 통해 해결하는 방법
            // https://www.mongodb.com/docs/realm/realm-query-language/
            let loadObject = loadRealm.objects(model).filter("endDay >= %@", Date())
            return loadObject.count
        case .all:
            let loadObject = loadRealm.objects(model)
            return loadObject.count
        case .flag:
            return 0
        case .completed:
            return 0
        }
    }
    
    
    // func

}


enum SortSction: CaseIterable {
    case titleSet
    case dateSet
    case prioritySet
    case onlyprioritySet
    
    var getQuery: String {
        switch self {
        case .titleSet:
            "titleTexts"
        case .dateSet:
            "endDay"
        case .prioritySet:
            "priorityNumber"
        case .onlyprioritySet:
            "priorityNumber"
        }
    }
}


//enum DetailViewActionCase:String, CaseIterable{
//    case endDaySorted = "마감일순"
//    case titleSorted = "제목순"
//    case priveritSorted = "우선순위 낮음순"
//    
//    var action: UIAction {
//        return compltionAction(title: self.rawValue) {
//            <#code#>
//        }
//    }
//    
//    private func compltionAction(title: String, compltionHanler: @escaping (() -> Void) ) -> UIAction {
//        
//        let action = UIAction(title: title) { _ in
//            compltionHanler()
//        }
//        return action
//    }
//}


/*
 // 2.1 이때 클래스의 속성(어튜류뷰트 or 컬럼)을 필터링하여 필요한 값만 가져올수 있습니다.
//        let loadObjectFilter = loadRealm.objects(NewToDoTable.self).where { myObject in
//            myObject.titleTexts == ""
//            myObject.memoTexts == ""
//            // .... etc
//        }
 
 // 2.2 MARK: 역관계 쿼리 알아보기
 
 // 3. MARK: 가져온 데이터의 갯수를 가져옵니다.
 */





//MARK: 상황별 섹션 분리
enum NewTodo:Int, CaseIterable{
    case memo = 1
    case details = 4
}

enum NewToDo{
    case memo
    case details(detailsGroup)
    
}

enum detailsGroup{
    case endDay
    case tag
    case prioritization
    case addImage
}
