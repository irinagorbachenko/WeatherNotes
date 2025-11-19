//
//  AddNotesViewModelTests.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 19.11.2025.
//
import SwiftUI

import XCTest
@testable import WeatherNotes

final class AddNotesViewModelTests: XCTestCase {
    
    var sut: AddNotesViewModel!
    var mockWeather: MockWeatherService!
    var mockStore: MockNotesStorage!
    
    static let fakeWeather = CurrentWeather(
        name: "Kyiv",
        main: .init(
            temp: 20,
            feelsLike: 21.5,
            tempMin: 19,
            tempMax: 25,
            humidity: 60
        ),
        weather: [
            .init(id: 1, main: "Clear", description: "sunny", icon: "01d")
        ]
    )
    
    override func setUp() {
        super.setUp()
        mockWeather = MockWeatherService()
        mockStore = MockNotesStorage()
        sut = AddNotesViewModel(weatherService: mockWeather, store: mockStore)
    }
    
    override func tearDown() {
        sut = nil
        mockWeather = nil
        mockStore = nil
        super.tearDown()
    }
    
    func testSaveSuccess() async throws {
        mockWeather.result = .success(Self.fakeWeather)
        
        sut.noteTitle = "Test Note"
        sut.city = "Kyiv"
        
        try await sut.save()
        
        XCTAssertEqual(mockStore.addedNotes.count, 1)
        XCTAssertEqual(mockStore.addedNotes.first?.temperature, 21.5)
    }
    
    func testSaveFailure() async {
        mockWeather.result = .failure(WeatherError.invalidResponse)
        
        sut.noteTitle = "Fail"
        sut.city = "Kyiv"
        
        do {
            _ = try await sut.save()
            XCTFail("Expected error")
        } catch {
            XCTAssertEqual(sut.errorMessage, WeatherError.invalidResponse.localizedDescription)
            XCTAssertTrue(mockStore.addedNotes.isEmpty)
        }
    }
    
    func testLoadingState() async {
        mockWeather.result = .success(Self.fakeWeather)
        
        XCTAssertFalse(sut.isLoading)
        
        let task = Task {
            try? await sut.save()
        }
        
        await MainActor.run {
            XCTAssertTrue(sut.isLoading)
        }
        
        await task.value
        
        await MainActor.run {
            XCTAssertFalse(sut.isLoading)
        }
    }
}
