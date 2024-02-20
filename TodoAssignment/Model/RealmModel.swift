//
//  RealmModel.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/15/24.
//

import UIKit
import RealmSwift

class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var folderName: String // 폴더이름
    @Persisted var regDate: Date // 등록날짜
    // Realm 에서 제공되는 List로 테이블이 테이블을 먹는 방식
    @Persisted var newTodoTable : List<NewToDoTable>
    
    convenience init(folderName: String, regDate: Date) {
        self.init()
        self.folderName = folderName
        self.regDate = regDate
    }
}

// MARK: 테이블 이름이 될 클래스 생성
class NewToDoTable: Object{
    // MARK: 이제 컬럼 또는 어튜류뷰트 를 선언
    // 1. 프라이머리가 될 하나의 컬럼을 선정
    @Persisted(primaryKey: true) var id: ObjectId
    
    // MARK: 프라이머리 기준으로 구분되어질 컬럼들을 선언!
    @Persisted var titleTexts : String // 새로생성될 타이틀
    @Persisted var memoTexts : String? // 메모 내용
    @Persisted var endDay: Date? // 마감일 지정
    
    @Persisted var tagText: String? // 태그안에 텍스트
    
    @Persisted var priorityNumber : Int // 우선순위 넘버
    
    @Persisted var flagBool : Bool // 플래그 Bool
    
    @Persisted var complite : Bool // 완료 했는지 Bool
    // @Persisted var onlyDate: Date? // 마감일 날짜만
    
    // MARK: 폴더와 공생을 위한 링크 정확히는 부모가 누군지 알기 위함
    @Persisted(originProperty: "newTodoTable" ) var folder:LinkingObjects<Folder>
    
    
    //MARK: convenience Init -> 모든 값을 넣어주지 않았을때 에러를 방지하기 위함이다.
    convenience
    init(title: String, memoTexts: String? = nil, endDay: Date? = nil, tagText: String? = nil, priorityNumber: Int, flagBool: Bool) {
        self.init()
        
        self.titleTexts = title
        self.memoTexts = memoTexts
        self.endDay = endDay
        self.tagText = tagText
        self.priorityNumber = priorityNumber
        self.flagBool = flagBool
    }
    
    
}

