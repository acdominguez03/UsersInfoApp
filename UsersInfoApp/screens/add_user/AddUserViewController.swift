//
//  AddUserViewController.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 29/5/24.
//

import UIKit

class AddUserViewController: UIViewController, UIColorPickerViewControllerDelegate {

    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etFavoriteCity: UITextField!
    @IBOutlet weak var etFavoriteNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Add user"

        // Do any additional setup after loading the view.
    }
    @IBAction func favoriteColorTap(_ sender: Any) {
        func presentColorPicker() {
            let colorPicker = UIColorPickerViewController()
            colorPicker.title = "Background Color"
            colorPicker.supportsAlpha = false
            colorPicker.delegate = self
            colorPicker.modalPresentationStyle = .popover
            colorPicker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
            self.present(colorPicker, animated: true)
        }
    }

}
