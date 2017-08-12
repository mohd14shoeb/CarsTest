//
//  CarAnnotation.swift
//  CarsTest
//
//  Created by Yurii Kolesnykov on 12.08.17.
//  Copyright © 2017 Yurii Kolesnykov. All rights reserved.
//

import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
    
    class func annotationsFrom(cars: [Car]) -> [CarAnnotation] {
        var carAnnotations = [CarAnnotation]()
        for car in cars {
            guard let latitude = car.latitude,
                  let longitude = car.longitude else {
                continue
            }
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            guard let name = car.name,
                let color = car.color else {
                    continue
            }
            
            let carAnnotation = CarAnnotation(title: name, subtitle: color, coordinate: coordinate)
            
            carAnnotations.append(carAnnotation)
            
        }
        
        return carAnnotations
    }
}
