//
//  SearchLocationViewController.swift
//  WeatherApp!
//
//  Created by Andrew Beauchamp on 11/15/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import UIKit

class SearchLocationViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let apiManager = APIManager()
    var geoCodingData: GeocodingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func handleError() {
        geoCodingData = nil
        weatherData = nil
    }
    
    func receiveWeatherData (latitide: Double, longitude : Double) {
        apiManager.getWeather(at:(latitide, longitude)) { (weatherData , error) in
            if let receivedError = error {
                print(receivedError.localizedDescription)
                self.handleError()
                return
            }
            if let receivedData = weatherData {
                self.weatherData = receivedData
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            } else {
                self.handleError()
                return
            }
        }
    }
    
    func getGeoCodingData (searchAddress: String) {
        apiManager.geocode(address: searchAddress) {
            (geoCodingData, error) in
            if let receivedError = error {
                print(receivedError.localizedDescription)
                self.handleError()
                return
            }
            if let receivedData = geoCodingData {
                self.geoCodingData = receivedData
                self.receiveWeatherData(latitide: receivedData.latitude, longitude: receivedData.longitude)
            } else {
                self.handleError()
                return
            }
            
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        getGeoCodingData(searchAddress: searchAddress)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? WeatherDisplayViewController,
            let receivedGeoCodingData = geoCodingData,
            let receivedWeatherData = weatherData
        {
            destinationVC.displayWeatherData = receivedWeatherData
            destinationVC.displayGeocodingData = receivedGeoCodingData
        }
    }
}

