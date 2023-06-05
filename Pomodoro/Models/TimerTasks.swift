//
//  Timer.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation

// Study
// Time is stored in seconds

class TimerTasks: Identifiable {

    // Duration is the time
    // Session is the number of times the duration will happen
    
    var id: UUID
    var name: String
    var isActiveTimer: Bool
    
    var studyDuration: Int
    var shortBreakDuration: Int
    var studySessions: Int

    
    var isLongBreakEnabled: Bool
    var longBreakDuration: Int
    
    init(
        id: UUID = UUID(),
        name: String,
        isActiveTimer: Bool,
        studyDuration: Int,
        studySessions: Int,
        shortBreakDuration: Int,
        longBreakEnabled: Bool,
        longBreakDuration: Int
    ){
        self.id = id
        self.name = name
        self.isActiveTimer = isActiveTimer
        
        self.studyDuration = studyDuration
        self.studySessions = studySessions
        
        self.shortBreakDuration = shortBreakDuration
        
        self.isLongBreakEnabled = longBreakEnabled
        self.longBreakDuration = longBreakDuration
    }
    
}

extension TimerTasks {
    

    
}


import RealmSwift

class TimerTask: Object, ObjectKeyIdentifiable, Sequence {
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
                        TimerTasks(
                            name: "DefaultTimer",
                            isActiveTimer: true,
                            studyDuration: 0,
                            studySessions: 0,
                            shortBreakDuration: 0,
                            longBreakEnabled: false,
                            longBreakDuration: 0
                        ))
                    realm.add(TimerTasks(
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
    
    static let sampleTimer: TimerTasks =
    TimerTasks(
        name: "DefaultTimer",
        isActiveTimer: true,
        studyDuration: 25,
        studySessions: 2,
        shortBreakDuration: 5,
        longBreakEnabled: true,
        longBreakDuration: 30
    )
    
    static let emptyTimer: TimerTasks =
    TimerTasks(
        name: "EmptyTimer",
        isActiveTimer: false,
        studyDuration: 0,
        studySessions: 0,
        shortBreakDuration: 0,
        longBreakEnabled: false,
        longBreakDuration: 0
    )
    
}
