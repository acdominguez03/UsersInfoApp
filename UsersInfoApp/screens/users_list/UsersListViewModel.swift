//
//  UsersListViewModel.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 11/6/24.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    @Published var usersFiltered: [UserModel] = []
    
    func getUsersOfDefaults() {
        UserDefaultsManager.shared.sync()
        users = UserDefaultsManager.shared.users
        usersFiltered = UserDefaultsManager.shared.users
    }
    
    func filterList(searchText: String, success: @escaping () -> Void) {
        usersFiltered = []
        if(searchText == "") {
            usersFiltered = users
        }
        
        users.forEach { user in
            if(user.name.uppercased().contains(searchText.uppercased())) {
                usersFiltered.append(user)
            }
        }
        
        success()
    }
    
    func removeUser(index: Int) {
        UserDefaultsManager.shared.users.remove(at: index)
        getUsersOfDefaults()
    }
}
