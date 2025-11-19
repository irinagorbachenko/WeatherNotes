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
    
    var sut: WeatherService!
    
    override func setUp() {
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        let session = URLSession(configuration: config)
        sut = WeatherService(session: session)
    }
    
    func testSuccessResponse() async throws {
        let json = """
        {
            "name": "Kyiv",
            "main": {
                "temp": 20,
                "feels_like": 18,
                "temp_min": 10,
                "temp_max": 30,
                "humidity": 70
            },
            "weather": [{
                "id": 800,
                "main": "Clear",
                "description": "Sunny",
                "icon": "01d"
            }]
        }
        """
        MockURLProtocol.stubResponseData = json.data(using: .utf8)
        MockURLProtocol.statusCode = 200
        
        let result = try await sut.currentWeather(for: "Kyiv")
        
        XCTAssertEqual(result.name, "Kyiv")
        XCTAssertEqual(result.main.feelsLike, 18)
    }
    
    func testBadStatusCode() async {
        MockURLProtocol.stubResponseData = Data()
        MockURLProtocol.statusCode = 404
        
        do {
            _ = try await sut.currentWeather(for: "Test")
            XCTFail("Expected badStatusCode")
        } catch let error as WeatherError {
            XCTAssertEqual(error, .badStatusCode(404))
        } catch {
            XCTFail("Unexpected error")
        }
    }
    
    func testDecodingFailure() async {
        MockURLProtocol.stubResponseData = "{}".data(using: .utf8)
        MockURLProtocol.statusCode = 200
        
        do {
            _ = try await sut.currentWeather(for: "Kyiv")
            XCTFail("Expected decodingFailed")
        } catch let error as WeatherError {
            XCTAssertEqual(error, .decodingFailed)
        } catch {
            XCTFail("Unexpected error")
        }
    }
}
