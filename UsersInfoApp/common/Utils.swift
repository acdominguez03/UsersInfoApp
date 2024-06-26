//
//  Utils.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 26/6/24.
//

import Foundation
import UIKit

struct Utils {
    static let shared = Utils()

    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    func datePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = .now
        return datePicker
    }
    
    func colorPicker() -> UIColorPickerViewController {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "Favorite Color"
        colorPicker.supportsAlpha = false
        colorPicker.modalPresentationStyle = .popover
        return colorPicker
    }
    
    func loadColor(colorComponents: [CGFloat]) -> UIColor {
        let color = UIColor(cgColor: .init(srgbRed: colorComponents[0], green: colorComponents[1], blue: colorComponents[2], alpha: colorComponents[03]))
        return color
    }
}
