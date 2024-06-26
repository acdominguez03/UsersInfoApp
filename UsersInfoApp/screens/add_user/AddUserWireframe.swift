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
        let viewModel: AddUserViewModel = createViewModel()
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private func createViewModel() -> AddUserViewModel {
        return AddUserViewModel()
    }
    
    func getViewController() -> AddUserViewController {
        return viewController
    }
    
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}
