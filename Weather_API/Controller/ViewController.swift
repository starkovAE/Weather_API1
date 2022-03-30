//
//  ViewController.swift
//  Weather_API
//
//  Created by Александр Старков on 29.03.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var feelLikeTemperatureLabel: UILabel!
    
    @IBOutlet weak var citiesLabel: UILabel!
     
    let networkWeatherManager = NetworkWeatherManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer //точность пару километров
        lm.requestWhenInUseAuthorization()
        return lm
     
    } ()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
        if CLLocationManager.locationServicesEnabled() { //у пользователя могут быть отклбчены настроики геопозиции (общая настройка). Если оно выключено
            locationManager.requestLocation() //requestLocation - один раз запрашивает геопозицию
        }
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) {[unowned self] cityName in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: cityName))
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
//MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return } //получаем последний элемент из массива геопозиций
        //получаем последнюю геопозицию по широте и долготе
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

