//
//  PreviewRealm.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 06/06/23.
//

import Foundation
import RealmSwift

class PreviewRealm {
    static var preview: Realm {
        var realm: Realm
        let identifier = "previewRealmTask"
        let config = Realm.Configuration(inMemoryIdentifier: identifier)
        do {
            realm = try Realm(configuration: config)
            
            try realm.write {
                if realm.object(ofType: Preference.self, forPrimaryKey: "hasFinishedOnboarding") == nil {
                    realm.add(Preference(key: "hasFinishedOnboarding", value: "true"))
                }
                if realm.object(ofType: Preference.self, forPrimaryKey: "username") == nil {
                    realm.add(Preference(key: "username", value: "Test"))
                }
                if realm.object(ofType: TimerTask.self, forPrimaryKey: "DefaultTimer") == nil {
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
                }
                if realm.object(ofType: TimerTask.self, forPrimaryKey: "EmptyTimer") == nil {
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
            }
            
            return realm
        } catch let error {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }
}

