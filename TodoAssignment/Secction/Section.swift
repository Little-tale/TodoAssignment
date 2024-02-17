//
//  Section.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import RealmSwift
// MARK: 잭님이 주신 과제의 원본 섹션


enum NewToDoList:Int, CaseIterable {
    case memo = 0
    case endDay = 1
    case tag = 2
    case prioritization = 3
    case addImage = 4
    case flag = 5
    
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
        case .flag:
            return "깃발"
        default: return ""
        }
    }
    
//    var getTableCell: UITableViewCell.AccessoryType {
//        switch self {
//        case .memo:
//            return TitleMemoTableCell.AccessoryType
//        case .endDay:
//            return OnlyTitleTableViewCell.self
//        case .tag:
//            return TitleMemoTableCell.self
//        case .prioritization:
//            return TitleMemoTableCell.self
//        case .addImage:
//            return TitleMemoTableCell.self
//        case .flag:
//            return TitleMemoTableCell.self
//        }
//    }
    
    /// 불명확 type, 존재  type
    /// coordinator, 라우터 --> 일단 다음에 시도하는 걸로
//    var nextView: UIViewController? {
//        switch self {
//        case .memo:
//            nil
//        case .endDay:
//            DatePickerViewController()
//        case .tag:
//            nil
//        case .prioritization:
//            nil
//        case .addImage:
//            nil
//        }
//    }
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
        // 딱히 디테일뷰에는 떠오르는 것이 없어서 여기를 왔다.
        // 표현식
        // "progressMinutes > 1 AND assignee == $0", "Ali"

        let loadRealm = try! Realm()
        let model = NewToDoTable.self
        switch self {
        case .today:
            // 현재 캘린더 생성
            let calender = Calendar.current
            // 캘린더 시작 날짜 현재 설정 ->
            let start = calender.startOfDay(for: Date())
            //DateAssistance().
            let end = calender.date(byAdding: .day, value: 1, to: start)
            // print(start, end) // 이둘의 사이를 하면 됨
           
            // MiGration 알아보기 SQL 언어 -> 둘다 하면 좋다.
            let data = loadRealm.objects(model).filter("endDay > %@ AND endDay < %@", start, end ?? "")
            //let data = loadRealm.objects(model).filter("endDay > \(start)")
            return data.count
        case .upcoming:
            //MARK: 쿼리 언어를 통해 해결하는 방법
            //  https://www.mongodb.com/docs/realm/realm-query-language/
            let loadObject = loadRealm.objects(model).filter("endDay >= %@", Date())
            // 수정된 사항
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
    var setTitle: String {
        switch self {
        case .titleSet:
            "제목순"
        case .dateSet:
            "날짜순"
        case .prioritySet:
            "우산순위순"
        case .onlyprioritySet:
            "우선순위만"
        }
    }
}

/*
 // MARK: 이렇게 할 필요가 없음 어느정도는 있겠지만
//            let date = DateAssistance().getOnlyDate(date: Date())
//            print(Date() )
//            guard let dates = date else {
//                return 0
//            }
//            let loadObject = loadRealm.objects(model).where { result in
//                result.onlyDate == dates
//            }
//            print(loadObject.count, dates)
 */
// 예시 let result = realm.objects(CompanyInfo.self).filter("id == 0")
// 단 매게변수는 $0 스타일
// 와 .... $0 으로 했는데 계속 터지다가
// %@ 로 매개변수 받으니 에러가 아나네


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



// MARK: TagInfo Case
//enum tagInfoCase: CaseIterable {
//    case none
//    case
//}
