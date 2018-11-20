//
//  WeatherData.swift
//  WeatherApp!
//
//  Created by Andrew Beauchamp on 11/16/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherData {
    enum Condition : String {
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case snow = "snow"
        case partlyCloudyDay = "partly-cloudy-day"
        case partkyCloudyNight = "partly-cloudy-night"
        
        //Computed property that selects an emoji for the icon label
        var icon: String {
            switch self {
            case .clearDay:
                return "🌞"
            case .clearNight:
                return "🌚"
            case .rain:
                return "🌧"
            case .sleet:
                return "🌨"
            case .wind:
                return "🌬"
            case .fog:
                return "🌫"
            case .snow:
                return "❄️"
            case .partlyCloudyDay:
                return "🌥"
            case .partkyCloudyNight:
                return "☁️"
            }
        }
    }
    enum WeatherDataKeys: String {
        case currently = "currently"
        case temperature = "temperature"
        case icon = "icon"
        case daily = "daily"
        case data = "data"
        case temperatureHigh = "temperatureHigh"
        case temperatureLow = "temperatureLow"
    }
    
    let temperature: Double
    let highTemperature: Double
    let lowTemperature: Double
    let condition: Condition
    
    init(temperature: Double, highTemperature: Double, lowTemperature: Double, condition: Condition) {
    self.temperature = temperature
    self.highTemperature = highTemperature
    self.lowTemperature = lowTemperature
    self.condition = condition
    }
    convenience init? (json:JSON) {
        guard let temperature = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.temperature.rawValue].double else {
            print("No temperature found")
            return nil
        }
        guard let highTemperature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureHigh.rawValue].double else {
            print("No high temperature is found")
            return nil
    }
        guard let lowTemperature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureLow.rawValue].double else {
            print("No low temperature found")
            return nil
        }
        
        guard let conditionString = json[WeatherDataKeys.currently.rawValue] [WeatherDataKeys.icon.rawValue].string else {
            print("No condition found")
            return nil
        }
        
        guard let condition = Condition(rawValue: conditionString) else {
            return nil
        }
        self.init(temperature: temperature, highTemperature: highTemperature, lowTemperature: lowTemperature, condition: condition)
}
}

