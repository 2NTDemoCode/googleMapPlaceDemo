//
//  DetailLocationViewController.swift
//  GoogleMapDynamic
//
//  Created by Minea Chem on 3/16/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps


class DetailLocationViewController: UIViewController {

   
    @IBOutlet weak var mapViewDetail: GMSMapView!
   
    @IBOutlet weak var titleLocation: UILabel!

    @IBOutlet weak var snipLocation: UILabel!
    
    @IBOutlet weak var latLocation: UILabel!
    
    @IBOutlet weak var longLocation: UILabel!
    
    @IBOutlet weak var addressLocation: UILabel!
    
    var allLocation = MarkerLocation()
    var titleLocate: String?
    var snip: String?
    var lat: CLLocationDegrees = 0.0
    var long: CLLocationDegrees = 0.0
    
    var address: String?
  //  var mapView: GMSMapView!
    
    // An array to hold the list of possible locations.
//    var likelyPlaces: [GMSPlace] = []
//    var selectedPlace: GMSPlace?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creates a marker in the center of the map.
       
            titleLocation.text = titleLocate
            snipLocation.text = snip
            latLocation.text = ("\(lat)")
            longLocation.text = ("\(long)")
            addressLocation.text = address
            
        
        
        

    initGoogleMaps()

    }
    func initGoogleMaps(){
        //11.537433, 104.886360
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        mapViewDetail.settings.myLocationButton = true
        self.mapViewDetail.camera = camera
        
        
        //add marker
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.icon = GMSMarker.markerImage(with: .gray)
        marker.title = titleLocate
        marker.snippet = snip
        marker.map = mapViewDetail
       mapViewDetail.isIndoorEnabled = true
    
    }

    
//    // Pass the selected place to the new view controller.
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "unwindToMain" {
//            if let nextViewController = segue.destination as? DetailLocationViewController {
//                nextViewController.selectedPlace = selectedPlace
//            }
//        }
//    }
}

