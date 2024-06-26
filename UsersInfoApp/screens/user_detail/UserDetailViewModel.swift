//
//  UserDetailViewModel.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 19/6/24.
//

import Foundation

class UserDetailViewModel: ObservableObject {
    
    @Published var user: UserModel?
     
    let userId: Int
    
    init(userId: Int) {
        self.userId = userId
    }
    
    func getUser() {
        user = UserDefaultsManager.shared.users.first(where: { user in
            user.id == userId
        })
    }
}
