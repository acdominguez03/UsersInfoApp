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
    private let ACTUALIDKEY = "ActualIdKey"
    
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
    
    var userId: Int {
        get {
            return users.count
        }
        set {
            userDefaults.setValue(users.count + 1, forKey: ACTUALIDKEY)
        }
    }
    
    func addUser(user: UserModel) {
        users.append(user)
    }
    
    func removeUser(index: Int) {
        users.remove(at: index)
    }
    
    func updateUser(userToUpdate: UserModel) {
        if let index = users.firstIndex(where: { user in
            user.id == userToUpdate.id
        }) {
            users[index] = userToUpdate
        }
    }
}
