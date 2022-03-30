//
//  NetworkWeatherManager.swift
//  Weather_API
//
//  Created by Александр Старков on 30.03.2022.
//

import UIKit

struct NetworkWeatherManager {
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)"
          guard let url = URL(string: urlString) else { return }
          let session = URLSession(configuration: .default)
         let task =  session.dataTask(with: url) { data, responce, error in
             if let data = data {
                 guard let dataString = String(data: data, encoding: .utf8) else { return }
                 print(dataString)
             }
          }
          task.resume()
    }
}

