//
//  MockWeatherService.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 19.11.2025.
//
@testable import WeatherNotes

class MockWeatherService: WeatherProvider {
    var result: Result<CurrentWeather, Error>?

    func currentWeather(for _: String) async throws -> CurrentWeather {
        switch result {
        case let .success(weather):
            return weather
        case let .failure(error):
            throw error
        case .none:
            fatalError("Result was not set")
        }
    }
}
