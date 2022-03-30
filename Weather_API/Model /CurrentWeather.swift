//
//  CurrentWeather.swift
//  Weather_API
//
//  Created by Александр Старков on 30.03.2022.
//

import UIKit

struct CurrentWeather {
    let cityName: String
    
    let temperature: Double
    var temeratureString: String { //преобразуем данные из дабл в строку, для корректного отображения в лэйбл
        return "\(temperature.rounded())"
    }
    let feelsLikeTemprature: Double
    var feelsLikeTempratureString: String {
        return "\(feelsLikeTemprature.rounded())"
    }
    let conditionCode: Int
    init?(currentWetherData: CurrentWetherData) {
        cityName = currentWetherData.name
        temperature = currentWetherData.main.temp
        feelsLikeTemprature = currentWetherData.main.feelsLike
        conditionCode = currentWetherData.weather.first?.id ?? 0
    }
}
