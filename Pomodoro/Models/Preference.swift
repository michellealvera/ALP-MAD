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
}
