//
//  DetailPlaceViewController.swift
//  GoogleMapDynamic
//
//  Created by mineachem on 4/20/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import GooglePlaces

class DetailPlaceViewController: UIViewController {

    @IBOutlet weak var bannerPlace: UIImageView!
    @IBOutlet weak var profilePlace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    

    
    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto)
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                self.bannerPlace.image = photo;
                self.profilePlace.image = photo;
            }
        })
    }

   
}
