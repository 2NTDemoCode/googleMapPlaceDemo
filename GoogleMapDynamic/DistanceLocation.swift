//
//  MapAndMarkerViewController.swift
//  GoogleMapDynamic
//
//  Created by Minea Chem on 4/3/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import GoogleMaps
import  GooglePlaces
import Alamofire
import SwiftyJSON

class DistanceLocation: UIViewController {
    
    @IBOutlet weak var showLocation: UILabel!
    @IBOutlet weak var map_marker: GMSMapView!
    var mapLocation = MapLocation()
    var locationManager = CLLocationManager()
    var userLatitude:Double?
    var userLongtitude:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        //googleMapView.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        DispatchQueue.main.async {
            
            self.locationManager.requestLocation()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()

    }
  
}

extension DistanceLocation: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while get location \(error)")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("Location AuthorizedAlways")
            map_marker.isMyLocationEnabled = true
            locationManager.startUpdatingLocation()
            
        case .authorizedWhenInUse:
            print("Location AutoriziedWhenInuse")
            map_marker.isMyLocationEnabled = true
            locationManager.startUpdatingLocation()
            
        case .denied:
            print("Location Denied")
            map_marker.isMyLocationEnabled = false
            locationManager.stopUpdatingLocation()
            
        case .notDetermined:
            print("Location NotDtermined")
            map_marker.isMyLocationEnabled = false
            
        case .restricted:
            print("Location Restricted")
            map_marker.isMyLocationEnabled = false
            locationManager.stopUpdatingLocation()
            
            
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last!
        userLatitude = newLocation.coordinate.latitude
        userLongtitude = newLocation.coordinate.longitude
        let currentLocatin  = CLLocation(latitude: userLatitude!, longitude:userLongtitude!)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLatitude!, longitude: userLongtitude!, zoom: 17.0)
        map_marker.camera = camera
        map_marker.animate(to: camera)
        map_marker.isMyLocationEnabled = true
        map_marker.settings.myLocationButton = true
        
        let geocdeURLString = mapLocation.baseURLGeocode + "latlng=" + String(describing: "\(userLatitude!),\(userLongtitude!)")
        
        
        if userLatitude != nil && userLongtitude != nil {
            
            Alamofire.request(geocdeURLString).responseJSON { (response) in
                print(response)
                if((response.result.value as? [String: Any]) != nil){
                    let swiftyJsonVar = JSON(response.result.value!)
                    let places = swiftyJsonVar["results"].arrayValue
                    
                    for myPlace in places {
                        
                        let format_address = myPlace["formatted_address"].string
                        print("format_address\(format_address!)")
                        let geometry = myPlace["geometry"].dictionary
                        print("geometry\(geometry!)")
                        let location = geometry?["location"]?.dictionary
                        print("location\(String(describing: location))")
                        if let lat = location?["lat"] , let lng = location?["lng"]{
                            print("testing lat:\(lat),and \(lng)")
                            
                            let geocoder = GMSGeocoder()
                            let locationGeo = CLLocationCoordinate2D(latitude: lat.double!, longitude: lng.double!)
                            
                            
                            geocoder.reverseGeocodeCoordinate(locationGeo, completionHandler: { (response, error) in
                                if let address = response?.firstResult() {
                                    
                                    
                                    let locationUser = CLLocation(latitude: lat.double!, longitude: lng.double!)
                                    
                                    //metre
                                    let metre = currentLocatin.distance(from: locationUser)
                                    
                                    
                                    if Int(metre) <= 500 && Int(metre) > 100{
                                        
                                        let alertController = UIAlertController(title: "\(Int(metre)) m", message: "Almost There", preferredStyle: UIAlertControllerStyle.alert)
                                        
                                        let okAction = UIAlertAction(title: "Welcome", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                                            
                                        }
                                        
                                        alertController.addAction(okAction)
                                        
                                        self.present(alertController, animated: true, completion: nil)
                                        
                                        self.showLocation.text   = ("\(address.country!),\n \(address.lines!)")
                                    }
                                    
                                    
                                    
                                    
                                }else {
                                    print("error\(String(describing: error))")
                                }
                                // if condition address
                                
                            })
                            // geocoder reverseGeocodeCoordinate
                            
                            
                            
                        }
                        // if lat and lng = web service
                        
                        
                    }
                    
                }
            }
            
            
        }
    }
    
    
}


