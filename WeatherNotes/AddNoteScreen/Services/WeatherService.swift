//
//  WeatherService.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import Foundation

enum WeatherError: Error {
    case invalidURL
    case invalidResponse
    case badStatusCode(Int)
    case decodingFailed
}

class WeatherService {
    func currentWeather() async -> CurrentWeather {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=50.4504&lon=30.5245&appid=789106f8ac934ed236407c792cc9067e")!
        var request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
            return currentWeather
        } catch {
            fatalError()
        }
    }
}
