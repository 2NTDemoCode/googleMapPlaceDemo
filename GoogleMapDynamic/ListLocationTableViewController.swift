//
//  ListLocationTableViewController.swift
//  GoogleMapDynamic
//
//  Created by Minea Chem on 4/3/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import GoogleMaps
class ListLocationTableViewController: UIViewController {
    @IBOutlet weak var tableviewlist: UITableView!
    
    var lat: CLLocationDegrees?
    var long: CLLocationDegrees?
    var address: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewlist.delegate = self
        tableviewlist.dataSource = self
        tableviewlist.reloadData()
        

            }

}

extension ListLocationTableViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellLocation", for: indexPath) as! ListLocationTableViewCell
        
        return cell
    }

}

extension ListLocationTableViewController: UITableViewDataSource{
    
}
