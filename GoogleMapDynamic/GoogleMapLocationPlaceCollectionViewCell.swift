//
//  GoogleMapLocationPlaceCollectionViewCell.swift
//  GoogleMapDynamic
//
//  Created by mineachem on 4/21/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import GooglePlaces
class GoogleMapLocationPlaceCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var profileLocation: UIImageView!
    
    @IBOutlet weak var nameLocation: UILabel!
    
    @IBOutlet weak var addressLocation: UILabel!
    
    @IBOutlet weak var kiloLocation: UILabel!
    
    
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
                self.profileLocation?.image = photo
            
            }
        })
    }

}
