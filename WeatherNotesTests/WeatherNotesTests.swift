//
//  WeatherNotesTests.swift
//  WeatherNotesTests
//
//  Created by Irina Gorbachenko on 17.11.2025.
//

import Testing
@testable import WeatherNotes
import XCTest

final class WeatherServiceTests: XCTestCase {
    private let fakeWeather = CurrentWeather(
        name: "Kyiv",
        main: .init(
            temp: 20,
            feelsLike: 21.5,
            tempMin: 19,
            tempMax: 25,
            humidity: 60
        ),
        weather: [
            .init(id: 1, main: "Clear", description: "sunny", icon: "01d"),
        ]
    )

    private var fakeWeatherData: Data {
        try! JSONEncoder().encode(fakeWeather)
    }

    func testSuccessResponse() async throws {
        let mockSession = MockURLSession()
        let response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        mockSession.dataToReturn = fakeWeatherData
        mockSession.responseToReturn = response
        let service = WeatherService(session: mockSession)

        let result = try await service.currentWeather(for: "Kyiv")

        XCTAssertEqual(result.name, "Kyiv")
        XCTAssertEqual(result.main.feelsLike, 21.5)
        XCTAssertEqual(result.weather.first?.icon, "01d")
    }

    func testBadStatusCode() async {
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
            if case let .badStatusCode(code) = error {
                // Then
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
