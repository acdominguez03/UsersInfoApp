//
//  UserDetailWireframe.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 19/6/24.
//

import Foundation
import UIKit

struct UserDetailWireframe {
    
    let userId: Int
    
    init(userId: Int) {
        self.userId = userId
    }
    
    private var viewController: UserDetailViewController {
        let viewController: UserDetailViewController = UserDetailViewController(nibName: "UserDetailView", bundle: nil)
        let viewModel: UserDetailViewModel = createViewModel()
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private func createViewModel() -> UserDetailViewModel {
        return UserDetailViewModel(userId: userId)
    }
    
    func getViewController() -> UserDetailViewController {
        return viewController
    }
    
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}
