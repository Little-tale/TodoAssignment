//
//  Section.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
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
    
}








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
