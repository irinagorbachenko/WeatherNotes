//
//  WeatherService.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import Foundation

enum WeatherError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case badStatusCode(Int)
    case decodingFailed
}

class WeatherService {
    private let session: URLSessionProtocol
    private let apiKey = "789106f8ac934ed236407c792cc9067e"
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    private func makeURL(forCity city: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        return components.url
    }
    
    func currentWeather(for city: String) async throws -> CurrentWeather {
        guard let url = makeURL(forCity: city) else {
            throw WeatherError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw WeatherError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw WeatherError.badStatusCode(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(CurrentWeather.self, from: data)
        } catch {
            throw WeatherError.decodingFailed
        }
    }
}
