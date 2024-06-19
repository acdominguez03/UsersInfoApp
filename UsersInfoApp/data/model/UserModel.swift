//
//  UserModel.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 5/6/24.
//

import Foundation
import UIKit

struct UserModel: Codable {
    let id: Int
    let name: String
    let favoriteColor: [CGFloat]
    let favoriteCity: String
    let favoriteNumber: Int
    let birthdate: String
    let locationLatitude: Double
    let locationLongitude: Double
}
