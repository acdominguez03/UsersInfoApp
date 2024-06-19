//
//  Extensions.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 19/6/24.
//

import Foundation
import UIKit

struct Extensions {
    func loadColor(colorComponents: [CGFloat]) -> UIColor {
        let color = UIColor(cgColor: .init(srgbRed: colorComponents[0], green: colorComponents[1], blue: colorComponents[2], alpha: colorComponents[03]))
        return color
    }
}
