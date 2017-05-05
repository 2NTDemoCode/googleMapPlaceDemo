//
//  MapMarker.swift
//  GoogleMapDynamic
//
//  Created by mineachem on 4/24/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit
import CoreLocation

protocol MapMarker: AnyObject
{
    var markerCoordinate: CLLocationCoordinate2D { get set }
    var markerTitle: String { get set }
    var markerColour: UIColor { get set }
    var markerClusterTitle: String { get set }
    var markerClusterColour: UIColor { get set }
    var markerClusterCount: Int { get set }
    
    var markerHashValue: Int { get }
    func isEqualToMarker(_ v: MapMarker) -> Bool
}
