//
//  GoogleMapViewController.swift
//  GoogleMapDynamic
//
//  Created by mineachem on 4/20/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapViewController: UIViewController {

    @IBOutlet weak var placeCollectionView: UICollectionView!
    
    @IBOutlet weak var googleMapView: GMSMapView!

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        googleMapView.clear()
       
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        googleMapView.settings.myLocationButton = true
         googleMapView.isMyLocationEnabled = true
        print("Google Map viewDidLoad")
        
        //MARK: - bring subview to in front of main view
        googleMapView.bringSubview(toFront: placeCollectionView)
        placeCollectionView.backgroundColor = UIColor.clear
        

       
        
        //MARK: -collection view delegate
        placeCollectionView.delegate = self
        placeCollectionView.dataSource = self
        
        
        listLikelyPlaces()
       
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Google Map viewDidAppear")
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
        
        self.placeCollectionView.reloadData()
    }

}


extension GoogleMapViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: 17.0)
        googleMapView.settings.myLocationButton = true
        googleMapView.isMyLocationEnabled = true
        if googleMapView.isHidden {
            googleMapView.isHidden = false
            googleMapView.camera = camera
        } else {
            googleMapView.animate(to: camera)
        }
        
        
        listLikelyPlaces()
        locationManager.stopUpdatingLocation()
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            googleMapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            googleMapView.settings.myLocationButton = true
            googleMapView.isMyLocationEnabled = true
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }

}


extension GoogleMapViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likelyPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellGoogleMaps = collectionView.dequeueReusableCell(withReuseIdentifier: "mapLocation", for: indexPath) as! GoogleMapLocationPlaceCollectionViewCell
        let collectionItemGoogleMap = likelyPlaces[indexPath.row]
        cellGoogleMaps.loadFirstPhotoForPlace(placeID: collectionItemGoogleMap.placeID)
        cellGoogleMaps.nameLocation.text = collectionItemGoogleMap.name
        cellGoogleMaps.addressLocation.text = collectionItemGoogleMap.formattedAddress
        cellGoogleMaps.kiloLocation.text = collectionItemGoogleMap.name
        return cellGoogleMaps
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailCollectionView = likelyPlaces[indexPath.row]
        //let detailPlaces: DetailPlaceViewController = DetailPlaceViewController()
        let detailPlaces = self.storyboard!.instantiateViewController(withIdentifier: "DetailPlaceViewController") as! DetailPlaceViewController
        print("row:\(detailCollectionView)")
        detailPlaces.navigationBar.title = detailCollectionView.name
        detailPlaces.loadFirstPhotoForPlace(placeID: detailCollectionView.placeID)
        navigationController?.pushViewController(detailPlaces, animated: true)
        
    }

    
}
