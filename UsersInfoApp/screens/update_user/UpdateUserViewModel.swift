//
//  UpdateUserViewModel.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 26/6/24.
//

import Foundation

class UpdateUserViewModel: ObservableObject {
    
    @Published var user: UserModel? = nil
    let userId: Int
    
    init(userId: Int) {
        self.userId = userId
        getUser()
    }
    
    func getUser() {
        user = UserDefaultsManager.shared.users.first(where: { user in
            user.id == userId
        })
    }
    
    func updateUser(name: String, city: String, number: String, birthdate: String, locationLatitude: Double?, locationLongitude: Double?, color: [CGFloat] ,completion: @escaping () -> Void) {
        
        guard let user = self.user else { return }
        
        if(!name.isEmpty) {
            user.name = name
        }
        
        if(!city.isEmpty) {
            user.favoriteCity = city
        }
        
        if(!number.isEmpty) {
            user.favoriteNumber = Int(number) ?? 0
        }
        
        if(!birthdate.isEmpty) {
            user.birthdate = birthdate
        }
        
        if let newLocationLatitude = locationLatitude {
            if(newLocationLatitude != user.locationLatitude) {
                user.locationLatitude = newLocationLatitude
            }
        }
        
        if let newLocationLongitude = locationLongitude {
            if(newLocationLongitude != user.locationLongitude) {
                user.locationLongitude = newLocationLongitude
            }
        }
        
        user.favoriteColor = color
        
        UserDefaultsManager.shared.updateUser(userToUpdate: user)
                
        completion()
    }
    
}
