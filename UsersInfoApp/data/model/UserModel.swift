//
//  UserModel.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 5/6/24.
//

import Foundation
import UIKit

class UserModel: Codable {
    let id: Int
    var name: String
    var favoriteColor: [CGFloat]
    var favoriteCity: String
    var favoriteNumber: Int
    var birthdate: String
    var locationLatitude: Double
    var locationLongitude: Double
    
    init(id: Int, name: String, favoriteColor: [CGFloat], favoriteCity: String, favoriteNumber: Int, birthdate: String, locationLatitude: Double, locationLongitude: Double) {
        self.id = id
        self.name = name
        self.favoriteColor = favoriteColor
        self.favoriteCity = favoriteCity
        self.favoriteNumber = favoriteNumber
        self.birthdate = birthdate
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
    }
}
