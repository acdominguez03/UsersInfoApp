//
//  MapWireframe.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 25/6/24.
//

import Foundation
import UIKit

struct MapWireframe {
    
    let city: String
    
    init(city: String) {
        self.city = city
    }
    
    private var viewController: MapViewController {
        let viewController: MapViewController = MapViewController(nibName: "MapView", bundle: nil)
        let viewModel: MapViewModel = createViewModel()
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private func createViewModel() -> MapViewModel {
        return MapViewModel(city: city)
    }
    
    func getViewController() -> MapViewController {
        return viewController
    }
    
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.present(viewController, animated: true)
    }
}
