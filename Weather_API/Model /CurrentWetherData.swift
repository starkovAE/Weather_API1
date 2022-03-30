//
//  CurrentWetherData.swift
//  Weather_API
//
//  Created by Александр Старков on 30.03.2022.
//

import UIKit
struct CurrentWetherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}
struct Weather: Decodable {
    let id: Int
}
