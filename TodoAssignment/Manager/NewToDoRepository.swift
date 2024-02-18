//
//  ToDoRepository.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/16/24.
//

import UIKit
import RealmSwift

typealias repositoryResults = Result<Void,Error>

protocol TodoRepository {
    /// 전체 테이블을 줍니다.
    func NewToDoRepository() -> Results<NewToDoTable>
    
    /// 새로운 테이블을 저장합니다.
    func createOfRecord(object: Object)
    
    /// 데이터 정렬을 해줍니다. 섹션별로 해드립니다.
    func dataSort(dataList: Results<NewToDoTable>, section: SortSction, toggle: Bool) -> Results<NewToDoTable>
    
    /// 테이블을 주시면 지워드립니다.
    func removeAt(_ item: NewToDoTable) -> Void
    
    ///  섹션을 주시면 해당하는 케이스별 카운트를 드립니다.
    func collctionListViewDisPatchForCount(_ section: AllListCellCase) -> Int
    
    /// 단어를 필터링(대소문자 구분 X )해 해당하는 뷰를 보여드립니다.
    func DetailFilterOfText(of: String) -> Results<NewToDoTable>
    
    /// 완료(Todo기준 )을 업데이트 해드립니다.
    func compliteUpdater(model_Id: ObjectId, ButtonBool: Bool) throws
}


final class NewToDoRepository: TodoRepository{
    
    let realm = try! Realm()
    let model = NewToDoTable.self
    
    func NewToDoRepository() -> Results<NewToDoTable> {
      return realm.objects(model)
    }
    
    func createOfRecord(object: Object) {
        print(realm.configuration.fileURL ?? "테이블 경로를 못찾음")
        do {
            try realm.write{
                realm.add(object)
            }
            print("파일 저장 성공","🦁🦁🦁🦁🦁🦁")
        } catch {
            print(error)
        }
    }
    
    // MARK: 데이터 정렬 
    func dataSort(dataList: Results<NewToDoTable>, section: SortSction, toggle: Bool) -> Results<NewToDoTable>{
        switch section {
        case .onlyprioritySet:
            return dataList.where {
                $0.priorityNumber > 0
            }
        case .prioritySet :
            return dataList.sorted(byKeyPath: section.getQuery, ascending: false)
        default :
            return dataList.sorted(byKeyPath: section.getQuery, ascending: toggle)
        }
    }
    
    func removeAt(_ item: NewToDoTable) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    
    func collctionListViewDisPatchForCount(_ section: AllListCellCase) -> Int {
        switch section {
        case .today:
            let calender = Calendar.current
            let start = calender.startOfDay(for: Date())
            let end = calender.date(byAdding: .day, value: 1, to: start)
            let todayIteral = realm.objects(model).where{
                $0.endDay > start && $0.endDay < end
            }
            return todayIteral.count
        case .upcoming:
            //// MMMMMMMMMM
            let future = realm.objects(model).where {
                $0.endDay > Date()
            }
            return future.count
        case .all:
    
            return realm.objects(model).count
        case .flag:
            let data =  realm.objects(model).where {
                $0.flagBool == true
            }
            return data.count
        case .completed:
            let compliteData = realm.objects(model).where {
                $0.complite == true
            }
            return compliteData.count
        }
        
    }
    // MARK: 완료된 데이터 Toggle
    func compliteUpdater(model_Id: ObjectId, ButtonBool: Bool) throws {
        do{
            let dataModel = realm.object(ofType: model, forPrimaryKey: model_Id)
            
            guard let dataModel = dataModel else {
    
                throw RealmErrorCase.noHaveTable
            }
            // -> toggle도 있지만 이게 더 확실할수도 있을것 같다.
            try realm.write {
                dataModel.complite = ButtonBool
            }
            
        } catch {
            throw RealmErrorCase.cantWriteObject
        }
    }
    
    func DetailFilterView(of: AllListCellCase) -> Results<NewToDoTable>{
        switch of {
        case .today:
            let calender = Calendar.current
            let start = calender.startOfDay(for: Date())
            let end = calender.date(byAdding: .day, value: 1, to: start)
            return realm.objects(model).where {
                $0.endDay > start && $0.endDay < end
            }
        case .upcoming:
            return realm.objects(model).where { $0.endDay > Date() }
        case .all:
            return realm.objects(model)
        case .flag:
            return realm.objects(model).where { $0.flagBool == true }
        case .completed:
            return realm.objects(model).where { $0.complite == true }
        }
        
    }
    
    /// 대소문자 구분안할겁니다....!
    func DetailFilterOfText(of: String) -> Results<NewToDoTable>{
        return realm.objects(model).where { $0.titleTexts.contains(of, options: .caseInsensitive) }
    }
    
    
}


/*
 
 //    func listViewRouter(caseOf: AllListCellCase) -> Results<NewToDoTable> {
 //        var repository = NewToDoRepository()
 //        switch caseOf {
 //        case .today:
 //            <#code#>
 //        case .upcoming:
 //            <#code#>
 //        case .all:
 //            return repository.fetchRecord()
 //        case .flag:
 //            <#code#>
 //        case .completed:
 //            <#code#>
 //        }
 //    }
 
 // MARK: UserDefaults 로 했었을때 저장 시점
 //        let data = TodoList(title: titleText, memo: self.memoText ?? "", lastDate: self.dateInfo, tag: self.tafInfo, privority: self.prioritizationIndex)
 //
 //        UserDefaultsManager.shared.appendData(data)
 // MARK: Realm 궁전을 통해 저장 시점
 
 // 1. 값을 넣어줄 구조체를 생성합니다
 
 //let saveRealm = try Realm()
 // 2. 클래스 init을 통해 값을 넣어 줍니다.
 // 2.1 해당 테이블이 어디에 있는지 찾아봅니다.
 //print(saveRealm.configuration.fileURL ?? "테이블 경로를 못찾음")
 
 
 // 1. 값을 넣어줄 구조체를 생성합니다
 do{
     let saveRealm = try Realm()
     // 2. 클래스 init을 통해 값을 넣어 줍니다.
         // 2.1 해당 테이블이 어디에 있는지 찾아봅니다.
     print(saveRealm.configuration.fileURL ?? "테이블 경로를 못찾음")
     
     let date = DateAssistance().getOnlyDate(date: dateInfo)
     print(date, "asdsadasdasad")
     
     // 2.2 클래스에 넣어줄 데이터(레코드!)를 구성합니다.
     let newToDoRecord = NewToDoTable(title: titleText, memoTexts: memoText, endDay: dateInfo, tagText: tagInfo, priorityNumber: prioritizationIndex, onlyDate: date)
     
     // 3. 해당 데이터를 Realm 데이터 베이스에 저장합니다.
     do {
         try saveRealm.write {
             saveRealm.add(newToDoRecord)
             showAlert(title: "저장 성공", message: "")
         }
     } catch {
         showAlert(title: "값을 저장하지 못했어요", message: "앱을 삭제하고 재시도 하세요!")
     }
     
 } catch {
     showAlert(title: "테이블 에러!()", message: "앱을 삭제하고 재시도 하세요!")
 }
 */
