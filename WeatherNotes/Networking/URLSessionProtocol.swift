//
//  URLSessionProtocol.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 19.11.2025.
//
import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
