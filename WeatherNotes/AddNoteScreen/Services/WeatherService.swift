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
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func currentWeather() async throws -> CurrentWeather {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=50.4504&lon=30.5245&appid=789106f8ac934ed236407c792cc9067e") else {
            throw WeatherError.invalidURL}
        var request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw WeatherError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw WeatherError.badStatusCode(httpResponse.statusCode)
        }
        
        do {
            let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
            return currentWeather
        } catch {
            throw WeatherError.decodingFailed
        }
    }
}
