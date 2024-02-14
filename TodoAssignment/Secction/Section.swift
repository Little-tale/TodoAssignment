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
