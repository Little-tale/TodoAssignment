//
//  AppDelegate.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // MARK: Realm에 콘피규레이션의 스키마 버전과, 마이그래이션 블럭을 통해 관리한다.
                            // 이때의 스키마는 현재 기준이다.
        let config = Realm.Configuration(schemaVersion: 5) { migration, oldSchemaVersion in
            // 단순 추가나 삭제는 아무런 작업없이 버전이 올랐다고만 명시해도된다.
            if oldSchemaVersion < 1 {} // test컬럼을 추가하였습니다.
            if oldSchemaVersion < 2 {} // test컬럼을 삭제하였습니다.
            if oldSchemaVersion < 3 { // memoTexts -> memoDetail 변경
                // 컬럼명이 변경되었을 경우엔 이렇게
                migration.renameProperty(onType: NewToDoTable.className(), from: "memoTexts", to: "memoDetail")
            }
            
            // 컬럼 결합
            if oldSchemaVersion < 4 {
                migration.enumerateObjects(ofType: NewToDoTable.className()) { oldObject, newObject in
                    guard let old = oldObject else {return}
                    guard let new = newObject else {return}
                    
                    new["testEnumerate"] = "테스트를 위한 글입니다. \(old["titleTexts"]!) 글이있네요! \(old["memoDetail"]!)"
                }
            }
            if oldSchemaVersion < 5 {
                migration.enumerateObjects(ofType: NewToDoTable.className()) { oldObject, newObject in
                    guard let new = newObject else {return}
                    
                    new["testNewElement"] = Int.random(in: 0...100)
                }
            }
            
        }
        print()
        // MARK: Realm에게 컨피규레이션을 전달한다.
        Realm.Configuration.defaultConfiguration = config
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

