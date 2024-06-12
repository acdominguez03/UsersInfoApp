//
//  UserDefaultsManager.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 11/6/24.
//

import Foundation


class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let USERSKEY = "UsersArray"
    
    private let userDefaults: UserDefaults
    
    init() {
        self.userDefaults = UserDefaults.standard
    }
    
    var users: [UserModel] {
        get {
            if let data = userDefaults.data(forKey: USERSKEY),
               let array = try? PropertyListDecoder().decode([UserModel].self, from: data) {
                return array
            } else {
                return []
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                userDefaults.set(data, forKey: USERSKEY)
            }
        }
    }
    
    func sync() {
        userDefaults.synchronize()
    }
}
