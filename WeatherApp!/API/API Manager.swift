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
    
    enum APIErrors: Error {
        case noData
        case  noResponse
        case invalidDate
    }
    

    
    func getWeather(at Location: location, onComplete: @escaping  ( WeatherData?, Error?)-> Void)  {
        let root = "https://api.darksky.net/forecast"
        let key = APIKeys.darkSkyKey
        let url = "\(root)/\(key)/\(Location.latitude),\(Location.longitude)"
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let weatherData = WeatherData(json: json) {
                    onComplete(weatherData, nil)
                } else {
                    onComplete(nil, APIErrors.invalidDate)
                }
                
            case .failure(let error):
                onComplete (nil, error)
            }
        }
    }
    
     func geocode(address: String, onCompletion: @escaping (GeocodingData?, Error?) -> Void ) {
        let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let url = googleURL + address + "&key=" + APIKeys.googleKey
        
        let request = Alamofire.request(url)
        
        request.responseJSON {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                if let geocodingData = GeocodingData(json: json) {
                    onCompletion(geocodingData, nil) }
                else {
                    onCompletion(nil,APIErrors.invalidDate)
                }
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }
    
    
}
