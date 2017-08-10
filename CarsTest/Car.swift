//
//  Car.swift
//  CarsTest
//
//  Created by Yurii Kolesnykov on 10.08.17.
//  Copyright © 2017 Yurii Kolesnykov. All rights reserved.
//

import Foundation
import SwiftyJSON

class Car {
    var color:              String?
    var fuelLevel:          String?
    var fuelType:           String?
    var group:              String?
    var id:                 String?
    var innerCleanliness:   String?
    var latitude:           Double?
    var longitude:          Double?
    var licensePlate:       String?
    var make:               String?
    var modelIdentifier:    String?
    var modelName:          String?
    var name:               String?
    var series:             String?
    var transmission:       String?
    
    class func parseJSONDictionary(json: JSON) -> Car {
        let car = Car()
        
        car.color = json["color"].string
        car.fuelLevel = json["fuelLevel"].string
        car.fuelType = json["fuelType"].string
        car.group = json["group"].string
        car.id = json["id"].string
        car.innerCleanliness = json["innerCleanliness"].string
        car.latitude = json["latitude"].double
        car.longitude = json["longitude"].double
        car.licensePlate = json["licensePlate"].string
        car.make = json["make"].string
        car.modelIdentifier = json["modelIdentifier"].string
        car.modelName = json["modelName"].string
        car.name = json["name"].string
        car.series = json["series"].string
        car.transmission = json["transmission"].string
        return car
    }
    
    class func parseJSONArray(json: JSON) -> [Car] {
        var cars = [Car]()
        if let jsonArr = json.array {
            for carDict:JSON in jsonArr  {
                let car = parseJSONDictionary(json: carDict)
                cars.append(car)
            }
        }
        return cars
    }
    
    var carImagePath: String? {
        guard let color = self.color else {
            return nil
        }
        
        guard let modelIdentifier = self.modelIdentifier else {
            return nil
        }
        
        let path = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\(modelIdentifier)/\(color)/2x/car.png"
        return path
    }
    
    var carImageURL: URL? {
        guard let carImagePath = carImagePath else {
            return nil
        }
        
        return URL(string: carImagePath)
    }
}
