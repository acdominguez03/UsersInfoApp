//
//  UsersListViewModel.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 11/6/24.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    
    func getUsersOfDefaults() {
        UserDefaultsManager.shared.sync()
        users = UserDefaultsManager.shared.users
    }
}
