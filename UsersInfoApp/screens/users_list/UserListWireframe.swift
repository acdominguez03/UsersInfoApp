//
//  UserListWireframe.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 11/6/24.
//

import Foundation
import UIKit

struct UsersListWireframe {
    
    private var viewController: UsersListViewController {
        let viewController: UsersListViewController = UsersListViewController(nibName: "UsersListView", bundle: nil)
        let viewModel: UsersListViewModel = createViewModel()
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private func createViewModel() -> UsersListViewModel {
        return UsersListViewModel()
    }
    
    func getViewController() -> UsersListViewController {
        return viewController
    }
    
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}

