//
//  ProfileViewModel.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 04/06/23.
//

import Foundation
import SwiftUI
import RealmSwift

extension ProfileView {
    class ViewModel: ObservableObject {
        @Published var isEditingName = false
        @Published var changeUsernameText = ""
        
        func editName(realm: Realm) -> Void {
            
            if isEditingName && !changeUsernameText.isEmpty {
                try? realm.write {
                    let username = realm.object(ofType: Preference.self, forPrimaryKey: "username")
                    username!.value = self.changeUsernameText
                }
            }
            
            self.isEditingName.toggle()
        }
    }
}
