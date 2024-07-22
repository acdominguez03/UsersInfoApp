//
//  AddUserViewController.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 29/5/24.
//

import UIKit
import CoreLocation

class AddUserViewController: UIViewController {

    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etFavoriteCity: UITextField!
    @IBOutlet weak var etFavoriteNumber: UITextField!
    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var etBirthDate: UITextField!
    
    var favoriteColor: UIColor? = nil
    var locationLatitude: Double? = nil
    var locationLongitude: Double? = nil
    
    private var viewModel: AddUserViewModel!
    
    @IBOutlet weak var selectedColorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add user"
        
        setUpDatePicker()
        
        setUpColorView()
    }
    
    func set(viewModel: AddUserViewModel) {
        self.viewModel = viewModel
    }
    
    @IBAction func tapSaveUser(_ sender: Any) {
        saveUser()
    }
    
    func saveUser() {
        
        guard let colorComponents = favoriteColor?.cgColor.components else {
            return
        }
        
        guard let name = etName.text, !name.isEmpty else {
            lbError.text = "Introduce un nombre por favor"
            return
        }
        
        guard let city = etFavoriteCity.text, !city.isEmpty else {
            lbError.text = "Introduce una ciudad por favor"
            return
        }
        
        guard let number = etFavoriteNumber.text, !number.isEmpty else {
            lbError.text = "Introduce un número por favor"
            return
        }
        
        guard let birthdate = etBirthDate.text, !birthdate.isEmpty else {
            lbError.text = "Introduce tu fecha de nacimiento por favor"
            return
        }
        
        guard let locationLatitude else {
            lbError.text = "Pulse el botón para obtener tu ubicación por favor"
            return
        }
        
        guard let locationLongitude else {
            return
        }
    
        let newUser = UserModel(
            id: viewModel.getActualId(),
            name: name,
            favoriteColor: colorComponents,
            favoriteCity: city,
            favoriteNumber: Int(number) ?? 0,
            birthdate: birthdate,
            locationLatitude: locationLatitude,
            locationLongitude: locationLongitude
        )
        
        viewModel.setUserToDefaults(user: newUser) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        etBirthDate.resignFirstResponder()
    }
    
    //color
    func setUpColorView() {
        selectedColorView.layer.masksToBounds = true
        selectedColorView.layer.cornerRadius = 25
        selectedColorView.backgroundColor = favoriteColor
    }
    
    @IBAction func getActualLocation(_ sender: Any) {
        LocationManager.shared.getUserLocation { [weak self] location in
            guard let strongSelf = self else {
                return
            }
            strongSelf.locationLatitude = location.coordinate.latitude.magnitude
            strongSelf.locationLongitude = location.coordinate.longitude.magnitude
        }
    }
    
    @IBAction func favoriteColorTap(_ sender: Any) {
        let colorPicker = Utils.shared.colorPicker()
        colorPicker.delegate = self
        colorPicker.popoverPresentationController?.sourceItem = navigationItem.rightBarButtonItem
        present(colorPicker, animated: true)
    }
    
    //datePicker
    func setUpDatePicker() {
        
        let datePicker = Utils.shared.datePicker()
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        
        etBirthDate.inputView = datePicker
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        etBirthDate.text = Utils.shared.formatDate(date: datePicker.date)
    }
    
    
}

extension AddUserViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        favoriteColor = viewController.selectedColor
        selectedColorView.backgroundColor = favoriteColor
    }
}
