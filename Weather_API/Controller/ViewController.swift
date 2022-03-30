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
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
        networkWeatherManager.fetchCurrentWeather(forCity: "London")
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) {[unowned self] cityName in
            self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
        }
    }
    private func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async { //тут происходит обновление интерфейса, поэтому мы помещаем этот код в глваную очередь (main) для того чтобы пользователь не ждал загрузки данных, мы проихводим ее асихнхронно (неодновременно). Чтобы интефейс работал. Если бы сделали синхронно - интерфейс бы не работал
            self.citiesLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temeratureString
            self.feelLikeTemperatureLabel.text = "\(weather.feelsLikeTempratureString)°C"
            self.weatherImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}

