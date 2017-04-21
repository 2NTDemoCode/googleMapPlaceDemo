//
//  GooglePlaceViewController.swift
//  GoogleMapDynamic
//
//  Created by mineachem on 4/20/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import GooglePlaces
class GooglePlaceViewController: UIViewController {

    @IBOutlet weak var collectionViewPlace: UICollectionView!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         placesClient = GMSPlacesClient.shared()
        
        collectionViewPlace.delegate = self
        collectionViewPlace.dataSource = self
        
            listLikelyPlaces()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Google Place view DidAppear")
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
            self.collectionViewPlace.reloadData()
        })
    }

    
}


extension GooglePlaceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likelyPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellGooglePlaces = collectionView.dequeueReusableCell(withReuseIdentifier: "google_places", for: indexPath) as! GooglePlaceCollectionViewCell
        let collectionItemGooglePlaces = likelyPlaces[indexPath.row]
        cellGooglePlaces.loadFirstPhotoForPlace(placeID: collectionItemGooglePlaces.placeID)
        cellGooglePlaces.namePlace.text = collectionItemGooglePlaces.name
        cellGooglePlaces.addressPlaces.text = collectionItemGooglePlaces.formattedAddress
        cellGooglePlaces.kiloPlaces.text = collectionItemGooglePlaces.name
        
        return cellGooglePlaces
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailCollectionView = likelyPlaces[indexPath.row]
        let detailPlaces = DetailPlaceViewController ()
        detailPlaces.loadFirstPhotoForPlace(placeID: detailCollectionView.placeID)
        self.navigationController?.pushViewController(detailPlaces, animated: true)
    
    }

    
}
