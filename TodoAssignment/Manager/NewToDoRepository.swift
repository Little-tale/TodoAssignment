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
    let folderModel = Folder.self
    
    lazy var list: Results<Folder> = realm.objects(Folder.self)
    
    
    func NewToDoRepository() -> Results<NewToDoTable> {
        return realm.objects(model)
    }
    func NewToDoFolder() -> Results<Folder> {
        return realm.objects(folderModel)
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
    
 
    
    func removeAt(_ item: NewToDoTable) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: 각 컬렉션뷰 셀에 갯수를 보여줍니다.
    func collctionListViewDisPatchForCount(_ section: AllListCellCase) -> Int {
        switch section {
        case .today:
            let calender = Calendar.current
            
            print("***",calender)
            //            calender.locale = Locale.current
            print("*****",calender)
            
            let start = calender.startOfDay(for: Date())
            //            let start = Date()
            let end = calender.date(byAdding: .day, value: 1, to: start)
            let todayIteral = realm.objects(model).where{
                $0.endDay >= start && $0.endDay < end
            }
            
            return todayIteral.count
        case .upcoming:
            //// MMMMMMMMMM
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let nextDay = calendar.date(byAdding: .day, value: 1, to: today)
            
            let future = realm.objects(model).where {
                $0.endDay >= nextDay
            }
            print(future)
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
    
    // MARK: 깃발을 토글합니다.
    func toggleOf(modle_ID: ObjectId){
        do {
            let model =  realm.object(ofType: model, forPrimaryKey: modle_ID)
            guard let model = model else {
                print("@@@@이걸던진다고?")
                throw RealmErrorCase.noHaveTable
            }
            print("@@@@@@@")
            try realm.write {
                model.flagBool.toggle()
            }
            
        } catch {
            print(error)
        }
    }
    
    /// 대소문자 구분안할겁니다....! 텍스트 검사
    func DetailFilterOfText(of: String) -> Results<NewToDoTable>{
        return realm.objects(model).where { $0.titleTexts.contains(of, options: .caseInsensitive) }
    }
    
    
    // MARK: FS캘린더 에서 사용할 Predicate 방법 필터
    func CalendarFilter(date : Date) -> Results<NewToDoTable>? {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start)
        //MARK: 오늘 배운 Predicate 방법으로 진행
        guard let end = end else {
            return nil
        }
        // MARK: 프레디케이트를 생성합니다.
        // 애플문서: 검색 또는 필터링을 위해 일련의 입력 값을 테스트하는 데 사용되는 논리 조건입니다.
        let predicate = NSPredicate(format: "endDay >= %@ && endDay < %@", start as NSDate, end as NSDate)
        
        let results = NewToDoRepository().filter(predicate)
        return results
    }
    
    
    
    // MARK: 두번째 대공사 키패스를 이용한 필터 뷰
    func DetailFilterViewForKeyPath(of: AllListCellCase, sortParam:(keyPath: String, ascending: Bool) = filterSortSection.title(ascending: true).parameter) -> Results<NewToDoTable> {
        let calender = Calendar.current
        let start = calender.startOfDay(for: Date())
        let end = calender.date(byAdding: .day, value: 1, to: start)
        switch of {
        case .today:
            return realm.objects(model).where {
                $0.endDay > start && $0.endDay < end
            }.sorted(byKeyPath: sortParam.keyPath, ascending: sortParam.ascending)
        case .upcoming:
            return realm.objects(model).where { $0.endDay > Date() }.sorted(byKeyPath: sortParam.keyPath, ascending: sortParam.ascending)
        case .all:
            return realm.objects(model).sorted(byKeyPath: sortParam.keyPath, ascending: sortParam.ascending)
        case .flag:
            return realm.objects(model)
                .where { $0.flagBool }.sorted(byKeyPath: sortParam.keyPath, ascending: sortParam.ascending)
        case .completed:
            return realm.objects(model).where { $0.complite }.sorted(byKeyPath: sortParam.keyPath, ascending: sortParam.ascending)
        }
    }
    // MARK: 새로 만들려는 스타일
    func DetailFilterViewForKey(of: AllListCellCase, parama: (keyPath: String, ascanding : Bool) = SortSction.titleSet.parametter(ats: .up)) -> Results<NewToDoTable> {
        let calender = Calendar.current
        let start = calender.startOfDay(for: Date())
        let end = calender.date(byAdding: .day, value: 1, to: start)
        switch of {
        case .today:
                return realm.objects(model).where {
                    $0.endDay > start && $0.endDay < end
                }.sorted(byKeyPath: parama.keyPath, ascending: parama.ascanding)
        case .upcoming:
            return realm.objects(model).where { $0.endDay > Date() }.sorted(byKeyPath: parama.keyPath, ascending: parama.ascanding)
        case .all:
            return realm.objects(model).sorted(byKeyPath: parama.keyPath, ascending: parama.ascanding)
        case .flag:
            return realm.objects(model)
                .where { $0.flagBool }.sorted(byKeyPath: parama.keyPath, ascending: parama.ascanding)
        case .completed:
            return realm.objects(model).where { $0.complite }.sorted(byKeyPath: parama.keyPath, ascending: parama.ascanding)
        }
    }
    
    
    
    // MARK: 진짜 모르겠습니다...
    // 어떻게 해야 폴더의 0, 1, 2 라는 인덱스가 있는데 그 인덱스 기준을 잡고
    // 그 인덱스별로 정렬이 되는데 Results<> 로 할지 전혀 모르겠다.... -> 뷰컨 모델이....
//    func FolderFilterViewForKeyPath(sortParam:(keyPath: String, ascending: Bool) = filterSortSection.title(ascending: true).parameter) -> List<NewToDoTable> {
//        realm.objects(folderModel.self).map
//        
//    }
//    
    
    // MARK: 새로운 폴더 생성하기
    func saveNewFolder(folderName: String){
        let data = Folder(folderName: folderName, regDate: Date())
        
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    // MARK: 폴더와 내부모두 제거
    func removeFolderAtAll(folderModel: Folder) {
        do{
            try realm.write {
                realm.delete(folderModel.newTodoTable)
                realm.delete(folderModel)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    // MARK: 첫번째 폴더만 배출
    func firstFolder() -> Folder? {
        return NewToDoFolder().first
    }
    // MARK: 테이블 주시면 폴더와 함께 저장해드려요!
    func saveInFolder(table: NewToDoTable,folder: Folder) {
        do {
            try realm.write {
                folder.newTodoTable.append(table)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

/*
 
 /// 데이터 정렬을 해줍니다. 섹션별로 해드립니다.
 func dataSort(dataList: Results<NewToDoTable>, section: SortSction, toggle: Bool) -> Results<NewToDoTable>
 
 
 /// DepleCate 예정이요니 이동 부탁드립니다.
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
 */

/*
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
 */



/*
 // 이렇게 되면 가드문이나 if let 무한인디!
//    func getDateInterval(firstdate: Date) -> ((String, String) -> Void) {
//        let calendar = Calendar.current
//        let start = calendar.startOfDay(for: firstdate)
//        let end = calendar.date(byAdding: .day, value: 1, to: start)
//        if let end = end {
//
//        }
//    }
 */
//enum settingSection: CaseIterable {
//    case endDay
//    case titleAt
//    case privo
//    
//    
//    var title: String{
//        switch self {
//        case .endDay:
//            "마감일순"
//        case .titleAt:
//            "제목순"
//        case .privo:
//            "우선순위순"
//        }
//    }
//    func type(bool: Bool) -> testSortSction {
//        switch self {
//        case .endDay:
//            testSortSction.dateSet(ascending: bool)
//        case .titleAt:
//            testSortSction.dateSet(ascending: bool)
//        case .privo:
//            testSortSction.dateSet(ascending: bool)
//        }
//    }
//}


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
