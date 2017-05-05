//
//  MapLocation.swift
//  GoogleMapDynamic
//
//  Created by Minea Chem on 3/24/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GooglePlaces
class MapLocation: NSObject {
    
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    let baseURLDistanceMatric = "https://maps.googleapis.com/maps/api/distancematrix/json?"
    let textSearchURL = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
    let nearbyURL = "https://maps.googleapis.com/maps/api/place/radarsearch/json?"
    
//    func geocodeAddress(lat:Double!,lng:Double!){
//        if (lat != nil && lng != nil){
//            let geocdeURLString = baseURLGeocode + "latlng=" + String(describing: ("\(lat),\(lng)"))
//            Alamofire.request(geocdeURLString).responseJSON(completionHandler: { (response) in
//                
//                if((response.result.value as? [String: Any]) != nil){
//                    let swiftyJsonVar = JSON(response.result.value!)
//                    let places = swiftyJsonVar["results"].arrayValue
//                    
//                    for myPlace in places {
//                        
//                        let format_address = myPlace["formatted_address"].string
//                        print("format_address\(format_address!)")
//                        let geometry = myPlace["geometry"].dictionary
//                        print("geometry\(geometry!)")
//                        let location = geometry?["location"]?.dictionary
//                        print("location\(location)")
//                        
//                        if let lat = location?["lat"] , let lng = location?["lng"]{
//                            
//                            
//                        }
//                        
//                        
//                    }
//                    
//                }
//            })
//        }
//        
//    }
    
    }
