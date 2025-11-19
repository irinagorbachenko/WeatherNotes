//
//  MockURLSession.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 19.11.2025.
//
import Foundation
@testable import WeatherNotes

class MockURLSession: URLSessionProtocol {
    var dataToReturn: Data?
    var responseToReturn: URLResponse?
    var errorToThrow: Error?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let errorToThrow {
            throw errorToThrow
        }
        return (dataToReturn ?? Data(), responseToReturn ?? URLResponse())
    }
}
