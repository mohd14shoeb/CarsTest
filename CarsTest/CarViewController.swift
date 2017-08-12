//
//  CarViewController.swift
//  CarsTest
//
//  Created by Yurii Kolesnykov on 12.08.17.
//  Copyright © 2017 Yurii Kolesnykov. All rights reserved.
//

import UIKit

extension UIViewController {
    func getCarsWithoutError(completion:@escaping (_ cars: [Car]?) -> Void)  {
        Networking.getCars { (cars: [Car]?, error: NSError?) in
            if let error = error {
                let controller = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(controller, animated: true, completion: nil)
            }
            
            completion(cars)
        }
    }
}
