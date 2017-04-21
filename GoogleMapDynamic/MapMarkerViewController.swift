//
//  ViewController.swift
//  GoogleMapDynamic
//
//  Created by Minea Chem on 3/16/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class MapMarkerViewController: UIViewController {

    @IBOutlet weak var googleMap: GMSMapView!
    var googleMapView:GMSMapView!
    var mapLocation = MapLocation()
    var locationManager = CLLocationManager()
    var allLocation = MarkerLocation()
     let infoMarker = GMSMarker()
    
    var userLatitude:Double?
    var userLongtitude:Double?

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initGoogleMaps()
    }

    //initGoogleMaps
    func initGoogleMaps(){
        //11.537433, 104.886360
        let camera = GMSCameraPosition.camera(withLatitude: 11.537433, longitude: 104.886360, zoom: 17.0)
        googleMap.delegate = self
         self.googleMap.camera = camera
        //googleMap.settings.myLocationButton = true
        
        AllLocations()
    }
    
    
    func AllLocations(){
//        // Creates a marker in the center of the map.
        for state in allLocation.states {
             let state_marker = GMSMarker()
            state_marker.position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.long)
            state_marker.title = state.name
            state_marker.snippet = "Hey, this is \(state.name)"
            state_marker.map = googleMap
           // markerDict[state.name] = state_marker
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSelect" {
            if let nextViewController = segue.destination as? DetailLocationViewController {
                if let maker = sender as? GMSMarker {
                    maker.icon = GMSMarker.markerImage(with: .yellow)
                    nextViewController.titleLocate = maker.title!
                    nextViewController.snip        = maker.snippet!
                    nextViewController.lat = maker.position.latitude
                    nextViewController.long = maker.position.longitude
                   
                    
                }
              //  nextViewController.likelyPlaces = likelyPlaces
            }
            
        }
    }
    
    //UIBarButtonSearch
    @IBAction func openSearchAddress(_ sender: UIBarButtonItem) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        self.present(autocompleteController, animated: true, completion: nil)
    }
    
    
}


//MapView Delegate
extension MapMarkerViewController: GMSMapViewDelegate{
   
     //  point to each marker when you tap
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        performSegue(withIdentifier: "segueToSelect", sender: marker)
        return true
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.googleMap.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.googleMap.isMyLocationEnabled = true
        if(gesture){
            googleMap.selectedMarker = nil
        }
    }
}

//AutocompleteViewControllerDelegate
extension MapMarkerViewController: GMSAutocompleteViewControllerDelegate{
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 17.0)
        self.googleMap.camera = camera
        googleMap.isMyLocationEnabled = true
        
        let currentLocation = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
        //add marker
       let marker = GMSMarker(position: currentLocation)
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.title = place.name
        marker.snippet = place.formattedAddress
        marker.map = googleMap
        
        print("place name:\(place.name)")
        print("place addrees\(String(describing: place.formattedAddress))")
        print("place attribution\(String(describing: place.attributions))")
        self.dismiss(animated: true, completion: nil) // dismiss after select place
        
        locationManager.stopUpdatingLocation()
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Select place is fail\(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil) //when cancel search
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
