//
//  UpdateUserWireframe.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 26/6/24.
//

import Foundation
import UIKit

struct UpdateUserWireframe {
    
    let userId: Int
    
    init(userId: Int) {
        self.userId = userId
    }
    
    private var viewController: UpdateUserViewController {
        let viewController: UpdateUserViewController = UpdateUserViewController(nibName: "UpdateUserView", bundle: nil)
        let viewModel: UpdateUserViewModel = createViewModel()
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private func createViewModel() -> UpdateUserViewModel {
        return UpdateUserViewModel(userId: userId)
    }
    
    func getViewController() -> UpdateUserViewController {
        return viewController
    }
    
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}

