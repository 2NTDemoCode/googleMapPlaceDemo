//
//  MarkerLocation.swift
//  GoogleMapDynamic
//
//  Created by Minea Chem on 3/16/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import GoogleMaps
class MarkerLocation{
    
    struct State {
        var name: String
        var snip: String
        var lat: CLLocationDegrees
        var long: CLLocationDegrees
        
        init(name: String, snip: String, lat: CLLocationDegrees,long: CLLocationDegrees) {
            self.name = name
            self.snip = snip
            self.lat = lat
            self.long = long
        }
    }
    
       
    var states = [
        //1.2NT
        State(name: "2NT", snip: "Nanita",lat: 11.537433 , long: 104.886360),
        //2. Amret
        State(name: "Armret", snip: "Microfinance", lat: 11.538244, long: 104.888209),
        //3.Amazon
        State(name: "Amazon", snip: "Cafe Shop", lat: 11.539400, long: 104.886568),
        //4.Bayon
        //11.537534, 104.883987
        State(name: "Bayon", snip: "TV studio", lat: 11.537534, long: 104.883987),
        //11.537460, 104.885972
        //5. Legend Cinema
        State(name: "Legend Cinema", snip: "Movie", lat: 11.537460, long: 104.885972),
        //6. new Steung mean chey market:11.537029, 104.886519
        State(name: "New Steung mean chey", snip: "Super Market", lat: 11.537029, long: 104.886519),
        //7. Nonmony Pagoda:11.537334, 104.889395
        State(name: "Nonmony Pagoda", snip: "pagoda", lat: 11.537334, long: 104.889395),
        //8.ACELEDA:11.535936, 104.886262
        State(name: "ACELEDA", snip: "finance place", lat: 11.535936, long: 104.886262),
        //9.MEBANG:11.539132, 104.889738
        State(name: "Armret", snip: "Microfinance", lat: 11.539132, long: 104.889738),
        //10.National institute of Business:11.537308, 104.887158
        State(name: "National institute of Business", snip: "Institute", lat: 11.537308, long: 104.887158)
    ]
    
    }
