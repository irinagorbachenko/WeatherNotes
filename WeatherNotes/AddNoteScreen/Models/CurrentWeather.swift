//
//  CurrentWeather.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import Foundation

struct CurrentWeather: Codable {
    let name: String
    let main: Main
    let weather: [Weather]

    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let humidity: Int

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case humidity
        }
    }

    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
}
