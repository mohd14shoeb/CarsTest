//
//  MasterViewController.swift
//  CarsTest
//
//  Created by Yurii Kolesnykov on 10.08.17.
//  Copyright © 2017 Yurii Kolesnykov. All rights reserved.
//

import UIKit
import AlamofireImage

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var cars = [Car]()


    override func viewDidLoad() {
        super.viewDidLoad()
        getCars()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let car = cars[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.car = car
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CarTableViewCell.CellHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseID, for: indexPath) as? CarTableViewCell {
            let car = cars[indexPath.row]
            cell.nameLabel!.text = car.name
            if let carImageURL = car.carImageURL {
                cell.picImageView.af_setImage(withURL:carImageURL)
            }
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func getCars() {
        getCarsWithoutError { cars in
            guard let cars = cars else {
                return
            }
            
            self.cars = cars
            self.tableView.reloadData()
        }
    }
}

