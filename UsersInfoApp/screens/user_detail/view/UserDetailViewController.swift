//
//  UserDetailViewController.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 19/6/24.
//

import UIKit
import Combine

class UserDetailViewController: UIViewController {
    
    var viewModel: UserDetailViewModel!

    @IBOutlet weak var favoriteColorView: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbFavoriteNumber: UILabel!
    @IBOutlet weak var lbBirthdate: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var favoriteCityBtn: UIButton!
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detail"
        
        viewModel.getUser()

        setUpView()
    }
    
    func set(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func setUpView() {
        viewModel.$user.sink { userModel in
            guard let user = userModel else { return }
            self.lbName.text = user.name
            self.lbFavoriteNumber.text = "Favorite number: " + String(user.favoriteNumber)
            self.lbBirthdate.text = "Birthdate: " + user.birthdate
            self.lbLocation.text = "Latitude: \(user.locationLatitude), longitude: \(user.locationLongitude)"
            self.favoriteCityBtn.setTitle("Favorite city: " + user.favoriteCity, for: .normal)
            self.favoriteColorView.layer.masksToBounds = true
            self.favoriteColorView.layer.cornerRadius = 25
            self.favoriteColorView.backgroundColor = Utils.shared.loadColor(colorComponents: user.favoriteColor)
        }.store(in: &cancellables)
    }
    

    @IBAction func showFavoriteCityInMap(_ sender: Any) {
        guard let city = viewModel.user?.favoriteCity else { return }
        MapWireframe(city: city).push(navigation: navigationController)
    }
    
}
