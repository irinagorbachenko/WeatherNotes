//
//  AddNotesViewModelTests.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 19.11.2025.
//
import Combine
import SwiftUI
@testable import WeatherNotes
import XCTest

final class AddNotesViewModelTests: XCTestCase {
    private var sut: AddNotesViewModel!
    private var mockWeather: MockWeatherService!
    private var mockStore: MockNotesStorage!
    private var cancellables = Set<AnyCancellable>()
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
        // Given
        mockWeather.result = .success(fakeWeather)
        sut.noteTitle = "Test Note"

        try await sut.save()
        XCTAssertEqual(mockStore.addedNotes.count, 1)
        XCTAssertEqual(mockStore.addedNotes.first?.temperature, 21.5)
    }

    func testSaveFailure() async {
        mockWeather.result = .failure(WeatherError.invalidResponse)
        sut.noteTitle = "Fail"

        do {
            try await sut.save()
            XCTFail("Expected error")
        } catch {
            XCTAssertEqual(sut.errorMessage, WeatherError.invalidResponse.localizedDescription)
            XCTAssertTrue(mockStore.addedNotes.isEmpty)
        }
    }

    func testLoadingState() {
        mockWeather.result = .success(fakeWeather)
        XCTAssertFalse(sut.isLoading)

        let exp = expectation(description: "Wait until toggle")
        exp.expectedFulfillmentCount = 3
        var isLoadingResults = [Bool]()
        sut.$isLoading.sink { isLoading in
            isLoadingResults.append(isLoading)
            exp.fulfill()
        }.store(in: &cancellables)

        Task {
            try await sut.save()
        }
        wait(for: [exp], timeout: 1.0)

        // Then
        XCTAssertEqual(isLoadingResults, [false, true, false])
    }
}
