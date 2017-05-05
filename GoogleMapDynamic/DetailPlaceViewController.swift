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

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var bannerPlace: UIImageView!
    @IBOutlet weak var profilePlace: UIImageView!
    @IBOutlet weak var namePlaces: UILabel!
    @IBOutlet weak var addressPlaces: UILabel!
    @IBOutlet weak var phonePlaces: UILabel!
    @IBOutlet weak var ratePlaces: UILabel!
    @IBOutlet weak var typesPlaces: UILabel!
    
    var name: String?
    var address: String?
    var phone: String?
    var rate: Float?
    var types: [String]?

    
    
       override func viewDidLoad() {
        super.viewDidLoad()
         print("Detail Place")
        
        namePlaces.text = name
        addressPlaces.text = address
        phonePlaces.text = phone
        ratePlaces.text = String(describing: rate)
        typesPlaces.text = types?.last
       
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
                self.bannerPlace?.image = photo;
                self.profilePlace?.image = photo;
            }
        })
    }

   
}
