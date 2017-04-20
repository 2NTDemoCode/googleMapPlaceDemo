//
//  PlaceViewController.swift
//  GoogleMapDynamic
//
//  Created by Minea Chem on 4/3/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import GooglePlaces
class PlaceViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var latLabel: UILabel!
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    // Cell reuse id (cells that scroll out of view can be reused).
    let cellReuseIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()

//        // Register the table view cell class and its reuse id.
//        tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller provides delegate methods and row data for the table view.
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.reloadData()
        
    }

    // Pass the selected place to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToMain" {
            if let nextViewController = segue.destination as? CurrentLocationViewController {
                nextViewController.selectedPlace = selectedPlace
            }
        }
    }
}

    
// Respond when a user selects a place.
extension PlaceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlace = likelyPlaces[indexPath.row]
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
}

// Populate the table with the list of most likely places.
extension PlaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likelyPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! PlaceTableViewCell
        let collectionItem = likelyPlaces[indexPath.row]
        
        cell.nameLabel.text = collectionItem.name
        cell.latLabel.text = String(collectionItem.coordinate.latitude)
        cell.longLabel.text = String( collectionItem.coordinate.longitude)
        cell.addressLabel.text = String(describing: collectionItem.formattedAddress)
        cell.ratLabel.text = String(collectionItem.rating)
        cell.priceLabel.text = String(describing: collectionItem.types)
        cell.webLabel.text = String(describing: collectionItem.website)
        
        return cell
    }
    
    // Adjust cell height to only show the first five items in the table
    // (scrolling is disabled in IB).
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.frame.size.height/5
//    }
    
    // Make table rows display at proper height if there are less than 5 items.
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == tableView.numberOfSections - 1) {
            return 1
        }
        return 0
    }
}
    

