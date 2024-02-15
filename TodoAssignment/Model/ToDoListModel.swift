//
//  ToDoListModel.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/15/24.
//

import Foundation

/*
 today
 예정
 전체
 깃발 표시
 완료됨
 
 ---------------
 |pk 
 |0
 |1
 |2
 |3
 */


struct TodoList:Codable {
    let title: String
    let memo: String
    let lastDate: Date?
    let tag: String?
    let privority: Int?
}
