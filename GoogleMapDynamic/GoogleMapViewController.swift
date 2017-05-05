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
import SwiftyJSON
import Alamofire


/// Point of Interest Item which implements the GMUClusterItem protocol.
class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    
    
    
    init(position: CLLocationCoordinate2D, name: String) {
        self.position = position
        self.name = name
       
       
        
    }
}




class GoogleMapViewController: UIViewController, GMUClusterManagerDelegate,GMSMapViewDelegate{

    @IBOutlet weak var placeCollectionView: UICollectionView!
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    var clusterManager: GMUClusterManager!
    var clusterManagers = [GMUClusterManager]()
    var mapLocation = MapLocation()
    var kClusterItemCount = 0
    var markers = [GMSMarker]()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    
    
    // The currently selected place.
    var selectedPlace: GMSPlace!
    
  //  var kClusterItemCount = 1000
    var kCameraLatitude: Double?
    var kCameraLongitude: Double?
    
    
    
       override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
           }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        placesClient = GMSPlacesClient.shared()
        
        print("Google Map viewDidLoad")
      
        googleMapView.delegate = self
        
        //MARK: -collection view delegate
        placeCollectionView.delegate = self
        placeCollectionView.dataSource = self
    
      listLikelyPlaces()
        hideCollectionView()
    }

    func hideCollectionView(){
        //MARK: - bring subview to in front of main view
        if placeCollectionView.isHidden == true {
            placeCollectionView.bringSubview(toFront: googleMapView)
            placeCollectionView.backgroundColor = UIColor.clear
            
        }

    }
    
    func showCollectionView() {
            googleMapView.bringSubview(toFront: placeCollectionView)
            placeCollectionView.backgroundColor = UIColor.clear
    }
   
    
    
    
    
        // Populate the array with the list of likely places.
    func listLikelyPlaces() {
        // Clean up from previous sessions.
//        likelyPlaces.removeAll()
        
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
                    let marker = GMSMarker()
                    self.markers.append(marker)
                    self.kCameraLatitude = place.coordinate.latitude
                    self.kCameraLongitude = place.coordinate.longitude
                    let camera = GMSCameraPosition.camera(withLatitude: self.kCameraLatitude!, longitude: self.kCameraLongitude!, zoom: 14)
                    self.googleMapView.camera = camera
                    self.googleMapView.isMyLocationEnabled = true
                    
                   self.likelyPlaces.append(place)
                    
                   
                    
                    
                    self.googleMapView.settings.myLocationButton = true
                    
                    self.googleMapView.isMyLocationEnabled = true
                    
        
                    // Set up the cluster manager with the supplied icon generator and
                    // renderer.
                    let iconGenerator = GMUDefaultClusterIconGenerator()
                    let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
                    let renderer = GMUDefaultClusterRenderer(mapView: self.googleMapView,
                                                             clusterIconGenerator: iconGenerator)
                    self.clusterManager = GMUClusterManager(map: self.googleMapView, algorithm: algorithm,
                                                       renderer: renderer)
                    
                    
                    // Generate and add random items to the cluster manager.
                    self.generateClusterItems()
                    
                    // Call cluster() after items have been added to perform the clustering
                    // and rendering on map.
                    self.clusterManager.cluster()
                    
                    // Register self to listen to both GMUClusterManagerDelegate and GMSMapViewDelegate events.
                    self.clusterManager.setDelegate(self, mapDelegate: self)
                }
            }
        })
      //  self.placeCollectionView.reloadData()
        
    }
    

    
    // Randomly generates cluster items within some extent of the camera and
    /// adds them to the cluster manager.
    private func generateClusterItems() {
        let extent = 0.01
         kClusterItemCount = markers.count
        
        for index in 1...kClusterItemCount {
            let lat = kCameraLatitude! + extent * randomScale()
            let lng = kCameraLongitude! + extent * randomScale()
            let name = "Item \(index)"
                        let item =
                POIItem(position: CLLocationCoordinate2DMake(lat,  lng),name: name)
            clusterManager.add(item)
            
        }
    
    }
    
    /// Returns a random value between -1.0 and 1.0.
     func randomScale() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Google Map viewDidAppear")
        
        
    }
    

    // MARK: - GMUClusterManagerDelegate
   
//    func clusterManager(_ clusterManager: GMUClusterManager, didTap clusterItem: GMUClusterItem) -> Bool {
//        let newCamera = GMSCameraPosition.camera(withTarget: clusterItem.position,zoom: googleMapView.camera.zoom + 1)
//        self.googleMapView.animate(to: newCamera)
//        print("camera:\(newCamera)")
//        return false
//    }
      func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster)  -> Bool {
       
        
        let newCamera = GMSCameraPosition.camera(withLatitude: cluster.position.latitude, longitude: cluster.position.longitude, zoom: 14)
        self.googleMapView.animate(to: newCamera)
        
//        var placeCluster = likelyPlaces.last!
        likelyPlaces.removeAll()
        for collect in cluster.items {
            let placeCluster = likelyPlaces.last!
                self.kCameraLatitude = collect.position.latitude
                self.kCameraLongitude = collect.position.longitude
            
                self.kCameraLatitude = placeCluster.coordinate.latitude
                self.kCameraLongitude = placeCluster.coordinate.longitude
            
                var postionsCluster = CLLocation(latitude: kCameraLatitude!, longitude: kCameraLongitude!)
                let positionsplace = CLLocation(latitude: kCameraLatitude!, longitude: kCameraLatitude!)
                
                postionsCluster = positionsplace
                 self.likelyPlaces.append(placeCluster)
            
            print("placeCluster",placeCluster)
            
        }
        self.placeCollectionView.reloadData()
        showCollectionView()
        
       // showCollectionView()
        
        return false
    }
    
    
       func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let poiItem = marker.userData as? POIItem {
            let places = self.likelyPlaces.last!
             poiItem.position.latitude = marker.position.latitude
            poiItem.position.longitude = marker.position.longitude
            
            marker.position = CLLocationCoordinate2D(latitude:places.coordinate.latitude , longitude: places.coordinate.longitude)
            marker.title = places.name
            poiItem.name = marker.title!
            poiItem.position = marker.position
            markers.append(marker)
            print("marker",marker)
          
        }else {
            
            print("tap cluster","no")
        }

        return false
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
       // print("row:\(detailCollectionView)")
        detailPlaces.loadFirstPhotoForPlace(placeID: detailCollectionView.placeID)
        detailPlaces.name = detailCollectionView.name
        detailPlaces.address = detailCollectionView.formattedAddress
        detailPlaces.phone = detailCollectionView.phoneNumber
        detailPlaces.rate = detailCollectionView.rating
        detailPlaces.types = detailCollectionView.types
        navigationController?.pushViewController(detailPlaces, animated: true)
        
    }

    
}
