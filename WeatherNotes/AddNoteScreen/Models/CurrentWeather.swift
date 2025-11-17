//
//  CurrentWeather.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import Foundation

struct CurrentWeather: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    struct Main: Decodable {
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
    
    struct Weather: Decodable {
        let id: Int
        let main: String       // e.g. "Rain", "Clouds"
        let description: String
        let icon: String       // e.g. "10d"
    }
}
