//
//  Preference.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 05/06/23.
//

import Foundation
import RealmSwift

class Preference: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var key: String = ""
    @Persisted var value = ""
    @Persisted var information = ""
    
    convenience init(key: String, value: String) {
        self.init()
        self.key = key
        self.value = value
        self.information = ""
    }
    
    static var previewRealm: Realm {
        var realm: Realm
        let identifier = "previewRealm"
        let config = Realm.Configuration(inMemoryIdentifier: identifier)
        do {
            realm = try Realm(configuration: config)
            
            // set preview data
            let realmObjects = realm.objects(Preference.self)
            if realmObjects.count == 2 {
                return realm
            } else {
                try realm.write {
                    realm.add(Preference(key: "hasFinishedOnboarding", value: "true"))
                    realm.add(Preference(key: "username", value: "Test"))
                }
                return realm
            }
        } catch let error {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }
    
}
