//
//  AddUserViewModel.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 11/6/24.
//

import Foundation

class AddUserViewModel: ObservableObject {
    
    let userDefaults: UserDefaultsManager
    
    init(userDefaults: UserDefaultsManager) {
        self.userDefaults = userDefaults
    }
    
    func setUserToDefaults(user: UserModel, completion: @escaping () -> Void) {
        var users = UserDefaultsManager.shared.users
        users.append(user)
        UserDefaultsManager.shared.users = users
        UserDefaultsManager.shared.sync()
        completion()
    }
    
}
