//
//  DateAssistance.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit

struct DateAssistance {
    // 2024-02-15 09:46:55 +0000
    let dateAssistance = DateFormatter()
    let dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    // MARK: 날짜만 나오게 해드립니다.
    /// 날짜만 나오게 해드릴께요!
    func getDate(date: Date?) -> String{
        guard let date = date else {
            return ""
        }
        dateAssistance.dateFormat = "yyyy년 M월 d일 "
        let dateString = dateAssistance.string(from: date)
        
        dateAssistance.dateFormat = dateFormat
        return dateString
    }
    func getOnlyDate(date: Date?) -> Date? {
        guard let date = date else {
            return nil
        }
        var calencer = Calendar.current
        let calender = calencer.date(from: calencer.dateComponents([.year,.month,.day], from: date))
        return calender
    }
}
