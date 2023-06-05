//
//  AppStorageJsonHelper.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 03/06/23.
//

import Foundation


struct AppStorageJsonHelper<T: Codable> {
    var key: String

    
    func load(`default`: T) -> T {
        
        if let loadedData = UserDefaults.standard.data(forKey: key) {
            debugPrint("Json exist");
            let data = try! JSONDecoder().decode(T.self, from: loadedData)
            debugPrint("Result", data)
            return data
        }
        
        return `default`
    }
    
    func save(`data`: T) -> Void {
        if let encoded = try? JSONEncoder().encode(`data`) {
            debugPrint("Saving json")
            UserDefaults.standard.set(encoded, forKey: key)
            debugPrint("Saved", encoded)
        }
    }
}
