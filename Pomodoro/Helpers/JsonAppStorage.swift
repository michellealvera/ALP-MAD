//
//  JsonAppStorage.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 03/06/23.
//

import Foundation


@propertyWrapper
struct JsonAppStorage<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            if let loadedData = UserDefaults.standard.data(forKey: key) {
                return (try? JSONDecoder().decode(T.self, from: loadedData)) ?? defaultValue
            }
            return defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}
