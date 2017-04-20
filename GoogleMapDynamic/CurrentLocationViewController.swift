//
//  CurrentLocationViewController.swift
//  GoogleMapDynamic
//
//  Created by Minea Chem on 4/3/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class CurrentLocationViewController: UIViewController {

    @IBOutlet weak var googlemapview: GMSMapView!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
        // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    
    var userLatitude:Double?
    var userLongtitude:Double?
    
    // Update the map once the user has made their selection.
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        // Clear the map.
        googlemapview.clear()
        
        // Add a marker to the map.
        if selectedPlace != nil {
            let marker = GMSMarker(position: (self.selectedPlace?.coordinate)!)
            marker.title = selectedPlace?.name
            marker.snippet = selectedPlace?.formattedAddress
            marker.map = googlemapview
            
            print("selected Place:",selectedPlace)
        }
        
        listLikelyPlaces()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.869405,longitude: 151.199,zoom: zoomLevel)
          googlemapview.settings.myLocationButton = true
        googlemapview.isMyLocationEnabled = true
        googlemapview.camera = camera
        googlemapview.isHidden = true
        
        listLikelyPlaces()
    }
    
    // Populate the array with the list of likely places.
    func listLikelyPlaces() {
        // Clean up from previous sessions.
        likelyPlaces.removeAll()
        
        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if let error = error {
                // TODO: Handle the error.
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            // Get likely places and add to the list.
            if let likelihoodList = placeLikelihoods {
                for likelihood in likelihoodList.likelihoods {
                    let place = likelihood.place
                    self.likelyPlaces.append(place)
                    print("place:",place)
                }
            }
        })
    }
    
    
    
    @IBAction func gotoDisplay(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToSelect", sender: self)
    }
    // Prepare the segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSelect" {
            if let nextViewController = segue.destination as? PlaceViewController {
                nextViewController.likelyPlaces = likelyPlaces
            }
        }
    }


   }

extension CurrentLocationViewController: CLLocationManagerDelegate{
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if googlemapview.isHidden {
            googlemapview.isHidden = false
            googlemapview.camera = camera
        } else {
            googlemapview.animate(to: camera)
        }
        
        
        listLikelyPlaces()
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            googlemapview.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}
