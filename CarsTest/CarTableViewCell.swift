//
//  CarTableViewCell.swift
//  CarsTest
//
//  Created by Yurii Kolesnykov on 10.08.17.
//  Copyright © 2017 Yurii Kolesnykov. All rights reserved.
//

import UIKit

fileprivate let kReuseID    = "CarTableViewCell"
fileprivate let kCellHeight = 80 as CGFloat

class CarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel:       UILabel!
    @IBOutlet weak var picImageView:    UIImageView!
    
    class var reuseID: String {
        return kReuseID
    }
    
    class var CellHeight: CGFloat {
        return kCellHeight
    }
}
