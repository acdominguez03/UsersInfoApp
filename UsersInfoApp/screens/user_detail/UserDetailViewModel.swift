//
//  UserDetailViewModel.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 19/6/24.
//

import Foundation

class UserDetailViewModel: ObservableObject {
    
    @Published var user: UserModel?
     
    let userDefaults: UserDefaultsManager
    let userId: Int
    
    init(userDefaults: UserDefaultsManager, userId: Int) {
        self.userDefaults = userDefaults
        self.userId = userId
    }
    
    func getUser() {
        user = userDefaults.users[userId]
    }
}
