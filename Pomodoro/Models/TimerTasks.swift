//
//  Timer.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation
import RealmSwift

class TimerTask: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var name: String
    @Persisted var isActiveTimer: Bool
    @Persisted var studyDuration: Int
    @Persisted var shortBreakDuration: Int
    @Persisted var studySessions: Int
    @Persisted var isLongBreakEnabled: Bool
    @Persisted var longBreakDuration: Int
    
    init(
        name: String,
        isActiveTimer: Bool,
        studyDuration: Int,
        studySessions: Int,
        shortBreakDuration: Int,
        longBreakEnabled: Bool,
        longBreakDuration: Int
    ){
        self.name = name
        self.isActiveTimer = isActiveTimer
        
        self.studyDuration = studyDuration
        self.studySessions = studySessions
        
        self.shortBreakDuration = shortBreakDuration
        
        self.isLongBreakEnabled = longBreakEnabled
        self.longBreakDuration = longBreakDuration
    }
    
    static var previewRealm: Realm {
        var realm: Realm
        let identifier = "previewRealm"
        let config = Realm.Configuration(inMemoryIdentifier: identifier)
        do {
            realm = try Realm(configuration: config)
            
            // set preview data
            let realmObjects = realm.objects(TimerTask.self)
            if realmObjects.count == 2 {
                return realm
            } else {
                try realm.write {
                    realm.add(
                        TimerTask(
                            name: "DefaultTimer",
                            isActiveTimer: true,
                            studyDuration: 25,
                            studySessions: 4,
                            shortBreakDuration: 1,
                            longBreakEnabled: false,
                            longBreakDuration: 0
                        ))
                    
                    realm.add(TimerTask(
                        name: "EmptyTimer",
                        isActiveTimer: false,
                        studyDuration: 0,
                        studySessions: 0,
                        shortBreakDuration: 0,
                        longBreakEnabled: false,
                        longBreakDuration: 0
                    ))
                    
                }
                
                return realm
            }
        } catch let error {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }
}
