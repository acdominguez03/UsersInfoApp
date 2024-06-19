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
        let usersDefaultManager: UserDefaultsManager = UserDefaultsManager()
        let viewModel: UserDetailViewModel = createViewModel(with: usersDefaultManager)
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private func createViewModel(with userDefaultsManager: UserDefaultsManager) -> UserDetailViewModel {
        return UserDetailViewModel(userDefaults: userDefaultsManager, userId: userId)
    }
    
    func getViewController() -> UserDetailViewController {
        return viewController
    }
    
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}
