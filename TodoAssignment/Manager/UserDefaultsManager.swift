//
//  UserDefaultsManager.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/15/24.
//

import Foundation

class UserDefaultsManager {
    private init() {}
    static let shared = UserDefaultsManager()
    private let userDefaults = UserDefaults.standard
    
    // 만약 구조체 모음을 관리할려면 인코딩 디코딩 작업이 필요하다는것을 알았다.
    var todoList : [TodoList]? {
        get{ // MARK: 이때는 JSon -> 나의 구조체로 변환한다.
            guard let userData = userDefaults.data(forKey: "todoList") else {
                return nil
            }
            do{
                let list = try JSONDecoder().decode([TodoList].self, from: userData)
                return list
            } catch {
                print("데이터 없어요")
                return nil
            }
        }
        set {// MARK: 통신 했던것처럼 이것도 Json 형식으로 변환한다.
            do{
                let data = try JSONEncoder().encode(newValue)
                userDefaults.set(data, forKey: "todoList")
            } catch {
                print("이건 진짜 문제임")
                
            }
            
        }
    }
    
    func appendData(_ item: TodoList) {
        let current = self.todoList
        
        guard var current = current else {
            var nodata: [TodoList] = []
            nodata.append(item)
            self.todoList = nodata
            return
        }
        current.append(item)
        self.todoList = current
    }
    
    // MARK: 지우는 로직도 만들어야함 배열이니까 인덱스로 혹은 데이터를 필터링 하기등
    

    
}



