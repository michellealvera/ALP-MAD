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
}
