//
//  MapViewController.swift
//  CarsTest
//
//  Created by Yurii Kolesnykov on 12.08.17.
//  Copyright © 2017 Yurii Kolesnykov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    let kDistance: Double = 10000
    let kPitch: CGFloat = 0
    let kHeading: Double = 0
    
    let MunichCoordinate = CLLocationCoordinate2D.init(latitude: 48.133333, longitude: 11.566667)
    var carAnnotations = [CarAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerCamera()
        getCars()        
    }
    
    func getCars() {
        getCarsWithoutError { cars in
            guard let cars = cars else {
                return
            }

            self.carAnnotations = CarAnnotation.annotationsFrom(cars: cars)
            
            guard let mapView = self.view as? MKMapView else {
                return
            }
            
            mapView.addAnnotations(self.carAnnotations)
        }
    }
    
    func centerCamera() {
        guard let mapView = self.view as? MKMapView else {
            return
        }
        
        let camera = MKMapCamera(lookingAtCenter: MunichCoordinate, fromDistance: kDistance, pitch: kPitch, heading: kHeading)
        mapView.camera = camera
    }
}
