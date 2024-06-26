//
//  MapViewController.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 24/6/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    var viewModel: MapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.updateMapView(map)
    }
    
    
    func set(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotationView = views.last {
            mapView.selectAnnotation(annotationView.annotation!, animated: false)
            mapView.showAnnotations(mapView.annotations, animated: true)
        }
    }
}
