//
//  Networking.swift
//  CarsTest
//
//  Created by Yurii Kolesnykov on 10.08.17.
//  Copyright © 2017 Yurii Kolesnykov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum API: String {
    case basePATH = "http://www.codetalk.de"
    case carsPATH = "/cars.json"
}

class Networking {
    class func getCars(completion:@escaping (_ cars: [Car]?, _ error: NSError?) -> Void) {
        Alamofire.request(API.basePATH.rawValue + API.carsPATH.rawValue).responseJSON { response in
            if response.result.isFailure {

                completion(nil, NSError(domain: "com.yurikoles.network",
                                        code: response.response?.statusCode ?? 11,
                                        userInfo: [NSLocalizedDescriptionKey: response.result.error?.localizedDescription ?? ""]))
                return
            }
            
            guard let data = response.result.value as? [Dictionary<String, Any>] else {
                completion(nil, NSError(domain: "com.yurikoles.network", code: 10, userInfo: nil))
                return
            }
            
            let json = JSON.init(data)
            let cars = Car.parseJSONArray(json: json)
            completion(cars, nil)
        }
    }
}
