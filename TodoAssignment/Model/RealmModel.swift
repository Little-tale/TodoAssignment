//
//  RealmModel.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/15/24.
//

import UIKit
import RealmSwift

// MARK: 테이블 이름이 될 클래스 생성
class NewToDoTable: Object {
    // MARK: 이제 컬럼 또는 어튜류뷰트 를 선언
    // 1. 프라이머리가 될 하나의 컬럼을 선정
    @Persisted(primaryKey: true) var id: ObjectId
    
    // MARK: 프라이머리 기준으로 구분되어질 컬럼들을 선언!
    @Persisted var titleTexts : String
    @Persisted var memoTexts : String?
    @Persisted var endDay: Date?
    @Persisted var tagText: String?
    @Persisted var priorityNumber : Int
    @Persisted var onlyDate: Date?
    
    //MARK: convenience Init -> 모든 값을 넣어주지 않았을때 에러를 방지하기 위함이다.
    convenience
    init(title: String, memoTexts: String? = nil, endDay: Date? = nil, tagText: String? = nil, priorityNumber: Int, onlyDate: Date?) {
        self.init()
        
        self.titleTexts = title
        self.memoTexts = memoTexts
        self.endDay = endDay
        self.tagText = tagText
        self.priorityNumber = priorityNumber
        self.onlyDate = onlyDate
    }
    
    
}
