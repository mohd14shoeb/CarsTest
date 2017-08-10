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

enum NetworkErorCodes: Int {
    case getFailure         = 10
    case invalidDataFormat  = 11
}

enum NetworkErorConstants: String {
    case errorDomain        = "com.yurikoles.network"
    case invalidDataDesc    = "Server had sent data in invalid format"
    case getFailureDesc     = "Netwrok or server problem"
}

enum API: String {
    case basePATH = "http://www.codetalk.de"
    case carsPATH = "/cars.json"
}

class Networking {
    class func getCars(completion:@escaping (_ cars: [Car]?, _ error: NSError?) -> Void) {
        Alamofire.request(API.basePATH.rawValue + API.carsPATH.rawValue).responseJSON { response in
            if response.result.isFailure {

                completion(nil, NSError(domain: NetworkErorConstants.errorDomain.rawValue,
                                        code: response.response?.statusCode ?? NetworkErorCodes.getFailure.rawValue,
                                        userInfo: [NSLocalizedDescriptionKey: response.result.error?.localizedDescription ?? NetworkErorConstants.getFailureDesc.rawValue]))
                return
            }
            
            guard let data = response.result.value as? [Dictionary<String, Any>] else {
                completion(nil, NSError(domain: NetworkErorConstants.errorDomain.rawValue,
                                        code: NetworkErorCodes.invalidDataFormat.rawValue,
                                        userInfo: [NSLocalizedDescriptionKey: NetworkErorConstants.invalidDataDesc.rawValue]))
                return
            }
            
            let json = JSON.init(data)
            let cars = Car.parseJSONArray(json: json)
            completion(cars, nil)
        }
    }
}
