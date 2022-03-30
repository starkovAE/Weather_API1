//
//  NetworkWeatherManager.swift
//  Weather_API
//
//  Created by Александр Старков on 30.03.2022.
//

import UIKit
import CoreLocation

class NetworkWeatherManager {
    var onCompletion:((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forCity city: String)  {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        performRequest(withURLString: urlString)
    }
    func fetchCurrentWeather(forLatitude latitude: CLLocationDegrees,forLongitude longitude: CLLocationDegrees)  {
        let urlString = 
        "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        performRequest(withURLString: urlString)
    }
    
   private func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
       let task =  session.dataTask(with: url) { data, responce, error in
           if let data = data { //сдесь хранится json
               guard let currentWeather =  self.parseJSON(withData: data) else { return }
               self.onCompletion?(currentWeather)
           }
        }
        task.resume()
    }
    
    private func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
           let currentWeatherData = try decoder.decode(CurrentWetherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWetherData: currentWeatherData) else { return nil }
            return currentWeather
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

