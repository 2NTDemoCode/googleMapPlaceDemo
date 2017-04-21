//
//  GooglePlaceCollectionViewCell.swift
//  GoogleMapDynamic
//
//  Created by mineachem on 4/20/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import GooglePlaces
class GooglePlaceCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imagePlaces: UIImageView!
    
    @IBOutlet weak var namePlace: UILabel!
    @IBOutlet weak var bannerPlaces: UIImageView!
    
    @IBOutlet weak var addressPlaces: UILabel!
    
    
    @IBOutlet weak var kiloPlaces: UILabel!
    
    
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
                self.imagePlaces.image = photo;
                self.bannerPlaces.image = photo;
            }
        })
    }
}
