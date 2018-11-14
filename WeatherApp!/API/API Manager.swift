//
//  API Manager.swift
//  WeatherApp!
//
//  Created by Andrew Beauchamp on 11/14/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct APIManager {
    static func getWeather (at Location: location ) {
        let root = "https://api.darksky.net/forecast/"
        let key = APIKeys.darkSkyKey
        let latitude = "37.8267"
        let longitude = "-122.4233"
        let url = "\(root)/\(key)/\(latitude),\(longitude)"
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
