//
//  Annotation.swift
//  GoogleMapDynamic
//
//  Created by mineachem on 4/24/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import CoreLocation
import UIKit

class Annotation: NSObject
{
    fileprivate var coordinate = CLLocationCoordinate2D(latitude: 13.103286, longitude: 103.202366)
    fileprivate var title: String = ""
    fileprivate var colour: UIColor = UIColor.red
    fileprivate var clusterTitle: String = ""
    fileprivate var clusterColour: UIColor = UIColor.purple
    fileprivate var clusterCount: Int = 0
    
    override var hash: Int
    {
        let toHash = "\(coordinate.latitude) \(coordinate.longitude)"
        return toHash.hash
    }
    
    override func isEqual(_ object: Any?) -> Bool
    {
        if let annotation = object as? Annotation {
            return self.hash == annotation.hash
        }
        
        return false
    }
}

extension Annotation: MapMarker
{
    var markerCoordinate: CLLocationCoordinate2D {
        get {
            return coordinate
        }
        set(newCoordinate) {
            coordinate = newCoordinate
        }
    }
    
    var markerTitle: String {
        get {
            return title
        }
        set(newTitle) {
            title = newTitle
        }
    }
    
    var markerColour: UIColor {
        get {
            return colour
        }
        set(newColour) {
            colour = newColour
        }
    }
    
    var markerClusterTitle: String {
        get {
            return clusterTitle
        }
        set(newTitle) {
            clusterTitle = newTitle
        }
    }
    
    var markerClusterColour: UIColor {
        get {
            return clusterColour
        }
        set(newColour) {
            clusterColour = newColour
        }
    }
    
    var markerClusterCount: Int {
        get {
            return clusterCount
        }
        set(newCount) {
            clusterCount = newCount
        }
    }
    
    var markerHashValue: Int {
        get {
            return hash
        }
    }
    
    func isEqualToMarker(_ v: MapMarker) -> Bool {
        return isEqual(v)
    }
}
