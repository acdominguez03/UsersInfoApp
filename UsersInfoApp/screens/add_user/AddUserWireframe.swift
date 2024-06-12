//
//  AddUserWireframe.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 12/6/24.
//

import Foundation
import UIKit

struct AddUserWireframe {
    
    private var viewController: AddUserViewController {
        let viewController: AddUserViewController = AddUserViewController(nibName: "AddUserView", bundle: nil)
        let usersDefaultManager: UserDefaultsManager = UserDefaultsManager()
        let viewModel: AddUserViewModel = createViewModel(with: usersDefaultManager)
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private func createViewModel(with userDefaultsManager: UserDefaultsManager) -> AddUserViewModel {
        return AddUserViewModel(userDefaults: userDefaultsManager)
    }
    
    func getViewController() -> AddUserViewController {
        return viewController
    }
    
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}
