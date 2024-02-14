//
//  DateAssistance.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit

struct DateAssistance {
    let dateAssistance = DateFormatter()
    
    // MARK: 날짜만 나오게 해드립니다.
    /// 날짜만 나오게 해드릴께요!
    func getDate(date: Date) -> String{
        dateAssistance.dateFormat = "yyyy년 M월 d일 "
        let dateString = dateAssistance.string(from: date)
        return dateString
    }
    
}
