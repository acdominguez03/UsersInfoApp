//
//  UpdateUserViewController.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 26/6/24.
//

import UIKit
import Combine

class UpdateUserViewController: UIViewController {
    
    var viewModel: UpdateUserViewModel!
    
    private var cancellables: Set<AnyCancellable> = []

    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etFavoriteNumber: UITextField!
    @IBOutlet weak var etFavoriteCity: UITextField!
    @IBOutlet weak var etBirthdate: UITextField!
    
    @IBOutlet weak var selectedColorView: UIView!
    
    var locationLatitude: Double? = nil
    var locationLongitude: Double? = nil
    var favoriteColor: UIColor? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUserAndUpdateUI()
        
        setUpDatePicker()
        setUpColorView()
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        etBirthdate.resignFirstResponder()
    }
    
    //Date picker
    func setUpDatePicker() {
        let datePicker = Utils.shared.datePicker()
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        etBirthdate.inputView = datePicker
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        etBirthdate.text = Utils.shared.formatDate(date: datePicker.date)
    }
    
    func setUpColorView() {
        selectedColorView.layer.masksToBounds = true
        selectedColorView.layer.cornerRadius = 25
        selectedColorView.backgroundColor = favoriteColor
    }
    
    @IBAction func getFavoriteColor(_ sender: Any) {
        guard let colorComponents = favoriteColor?.cgColor.components else {
            return
        }
        
        let colorPicker = Utils.shared.colorPicker()
        colorPicker.delegate = self
        colorPicker.selectedColor = Utils.shared.loadColor(colorComponents: colorComponents)
        colorPicker.popoverPresentationController?.sourceItem = navigationItem.rightBarButtonItem
        present(colorPicker, animated: true)
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
    
    @IBAction func updateUser(_ sender: Any) {
        checkUserUpdated()
    }
    
    func getUserAndUpdateUI() {
        viewModel.$user.sink { user in
            guard let user = user else { return }
            self.etName.placeholder = user.name
            self.etFavoriteNumber.placeholder = String(user.favoriteNumber)
            self.etFavoriteCity.placeholder = user.favoriteCity
            self.etBirthdate.placeholder = user.birthdate
            self.favoriteColor = Utils.shared.loadColor(colorComponents: user.favoriteColor)
        }.store(in: &cancellables)
    }
    
    func checkUserUpdated() {
        
        guard let name = etName.text else {
            return
        }
        
        guard let number = etFavoriteNumber.text else {
            return
        }
        
        guard let city = etFavoriteCity.text else {
            return
        }
        
        guard let birthday = etBirthdate.text else {
            return
        }
        
        guard let colorComponents = favoriteColor?.cgColor.components else {
            return
        }
        
        viewModel.updateUser(name: name, city: city, number: number, birthdate: birthday, locationLatitude: locationLatitude, locationLongitude: locationLongitude, color: colorComponents) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func set(viewModel: UpdateUserViewModel) {
        self.viewModel = viewModel
    }

}

extension UpdateUserViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        favoriteColor = viewController.selectedColor
        selectedColorView.backgroundColor = favoriteColor
    }
}
