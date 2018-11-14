//
//  ViewController.swift
//  WeatherApp!
//
//  Created by Andrew Beauchamp on 11/14/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let latitude = 37.8267
        let longitude = -122.4233
        
        APIManager.getWeather(at: (latitude, longitude))
        
    }
    
    }




