//
//  ProfileView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 23/05/23.
//

import SwiftUI
import RealmSwift

struct ProfileView: View {
    
    
    @StateObject var vm: ViewModel = ViewModel()
    
    @Environment(\.realm) var realm
    
    
    @ObservedResults(
        Preference.self,
        where: { $0.key == "username" }
    ) var username
    
    
    var body: some View {
        List {
            Section(header: Text("Profile Information")) {
                HStack(spacing: 20) {
                    
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color("Violet 500"))
                    
                    if vm.isEditingName {
                        TextField(
                            username.first!.value,
                            text: $vm.changeUsernameText
                        )
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("Violet 500"))
                        
                    } else {
                        Text(username.first!.value)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color("Violet 500"))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        vm.editName(realm: realm)
                    }) {
                        Image(systemName: vm.isEditingName ? "checkmark" : "pencil")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color("Violet 500"))
                    }
                }
            }
            
            
            Section(header: Text("Danger Zone")) {
                Button("Clear timer") {
                    
                }.foregroundColor(.red)
                
                Button("Reset application data") {
                    
                }.foregroundColor(.red)
            }
            
        }
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileView()
            .environment(\.realm, Preference.previewRealm)
        
    }
}
