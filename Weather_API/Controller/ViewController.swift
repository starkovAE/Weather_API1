//
//  ViewController.swift
//  Weather_API
//
//  Created by Александр Старков on 29.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var feelLikeTemperatureLabel: UILabel!
    
    @IBOutlet weak var citiesLabel: UILabel!
     
    
    let networkWeatherManager = NetworkWeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherManager.fetchCurrentWeather(forCity: "London")
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { cityName in
            self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
        }
    }
    
}

