//
//  WeatherNotesTests.swift
//  WeatherNotesTests
//
//  Created by Irina Gorbachenko on 17.11.2025.
//

import Testing
import XCTest
@testable import WeatherNotes

final class WeatherServiceTests: XCTestCase {
    
    func testSuccessResponse() async throws {
        let mockSession = MockURLSession()
        
        let weatherJSON = """
        {
          "name": "Kyiv",
          "main": { 
            "temp": 10,
            "feels_like": 8,
            "temp_min": 8,
            "temp_max": 12,
            "humidity": 70
          },
          "weather": [
            { 
              "id": 1,
              "main": "Clear",
              "description": "clear sky",
              "icon": "01d"
            }
          ]
        }

        """.data(using: .utf8)!
        
        let response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        mockSession.dataToReturn = weatherJSON
        mockSession.responseToReturn = response
        
        let service = WeatherService(session: mockSession)
        
        let result = try await service.currentWeather(for: "Kyiv")
        
        XCTAssertEqual(result.name, "Kyiv")
        XCTAssertEqual(result.main.feelsLike, 8)
        XCTAssertEqual(result.weather.first?.icon, "01d")
    }
    
    func testBadStatusCode() async {
        // GIVEN
        let mockSession = MockURLSession()
        
        mockSession.dataToReturn = Data()
        mockSession.responseToReturn = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )!
        
        let service = WeatherService(session: mockSession)
        
        do {
            _ = try await service.currentWeather(for: "Kyiv")
            XCTFail("Should throw badStatusCode")
        } catch let error as WeatherError {
            if case .badStatusCode(let code) = error {
                XCTAssertEqual(code, 404)
            } else {
                XCTFail("Wrong error thrown: \(error)")
            }
        } catch {
            XCTFail("Wrong error type")
        }
    }
    
    func testDecodingFailed() async {
        let mockSession = MockURLSession()
        
        mockSession.dataToReturn = "{ invalid json }".data(using: .utf8)
        mockSession.responseToReturn = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        let service = WeatherService(session: mockSession)
        
        do {
            _ = try await service.currentWeather(for: "Kyiv")
            XCTFail("Should throw decodingFailed")
        } catch let error as WeatherError {
            XCTAssertEqual(error, .decodingFailed)
        } catch {
            XCTFail("Unexpected error")
        }
    }
}
