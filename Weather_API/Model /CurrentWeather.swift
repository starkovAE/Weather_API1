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
        return String(format: "%.0f", temperature) //такая запись говорит о том что будет 0 знаков после запятой, если поставить 1 будет один
    }
    let feelsLikeTemprature: Double
    var feelsLikeTempratureString: String {
        return String(format: "%.0f", feelsLikeTemprature)
    }
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "smoke.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
          return "clear.fill"
        }
    }
    init?(currentWetherData: CurrentWetherData) {
        cityName = currentWetherData.name
        temperature = currentWetherData.main.temp
        feelsLikeTemprature = currentWetherData.main.feelsLike
        conditionCode = currentWetherData.weather.first?.id ?? 0
    }
}
