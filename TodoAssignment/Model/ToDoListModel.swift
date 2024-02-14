//
//  ToDoListModel.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/15/24.
//

import Foundation

struct TodoList:Codable {
    let title: String
    let memo: String
    let lastDate: Date?
    let tag: String?
    let privority: Int?
}
