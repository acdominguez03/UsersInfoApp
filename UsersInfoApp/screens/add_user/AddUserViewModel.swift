//
//  AddUserViewModel.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 11/6/24.
//

import Foundation

class AddUserViewModel: ObservableObject {
    
    func setUserToDefaults(user: UserModel, completion: @escaping () -> Void) {
        UserDefaultsManager.shared.addUser(user: user)
        completion()
    }
    
    func getActualId() -> Int {
        return UserDefaultsManager.shared.userId
    }
    
}
