//
//  NetworkWeatherManager.swift
//  Weather_API
//
//  Created by Александр Старков on 30.03.2022.
//

import UIKit

struct NetworkWeatherManager {
    func fetchCurrentWeather(forCity city: String,  completionHandler: @escaping (CurrentWeather) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)"
          guard let url = URL(string: urlString) else { return }
          let session = URLSession(configuration: .default)
         let task =  session.dataTask(with: url) { data, responce, error in
             if let data = data { //сдесь хранится json
                 guard let currentWeather =  self.parseJSON(withData: data) else { return }
                 completionHandler(currentWeather)
             }
          }
          task.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
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

