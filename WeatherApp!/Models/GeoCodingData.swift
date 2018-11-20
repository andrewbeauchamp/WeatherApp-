//
//  GeoCodingData.swift
//  WeatherApp!
//
//  Created by Andrew Beauchamp on 11/19/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import Foundation
import SwiftyJSON

class GeocodingData {
    enum GeoCodeDataKeys: String {
        case results = "results"
        case formattedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "lat"
        case longitude = "lng"
    }
    
    var formattedAddress : String
    var latitude: Double
    var longitude: Double
    
    init(formattedAddress: String, latitude: Double, longitude: Double) {
        self.formattedAddress = formattedAddress
        self.latitude = latitude
        self.longitude = longitude
    }
    
    convenience init?(json: JSON) {
        guard let results = json[GeoCodeDataKeys.results.rawValue].array,
            results.count > 0 else {
                return nil
        }
        guard let formattedAddress = results[0][GeoCodeDataKeys.formattedAddress.rawValue].string
            else {
                print("no formatted address found")
                return nil
        }
        guard let latitude = results[0][GeoCodeDataKeys.geometry.rawValue][GeoCodeDataKeys.location.rawValue][GeoCodeDataKeys.latitude.rawValue].double
            else {
                print("no latitude found")
                return nil
        }
        guard let longitude = results[0][GeoCodeDataKeys.geometry.rawValue][GeoCodeDataKeys.location.rawValue][GeoCodeDataKeys.longitude.rawValue].double
            else {
                print("no longitude found")
                return nil
    }
        self.init(formattedAddress: formattedAddress, latitude: latitude, longitude: longitude)

}
}
