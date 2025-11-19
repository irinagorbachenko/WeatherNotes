//
//  MockWeatherService.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 19.11.2025.
//
@testable import WeatherNotes

class MockWeatherService: WeatherService {
    var result: Result<CurrentWeather, Error>?
    
    override func currentWeather(for city: String) async throws -> CurrentWeather {
        switch result {
        case .success(let weather):
            return weather
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result was not set")
        }
    }
}
