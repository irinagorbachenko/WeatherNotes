//
//  MockURLProtocol.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 18.11.2025.
//
import Foundation

class MockURLProtocol: URLProtocol {
    static var stubResponseData: Data?
    static var statusCode = 200
    
    override class func canInit(with request: URLRequest) -> Bool { true }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    
    override func startLoading() {
        if let data = MockURLProtocol.stubResponseData {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: MockURLProtocol.statusCode,
                httpVersion: nil,
                headerFields: nil
            )!
            
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        } else {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: MockURLProtocol.statusCode,
                httpVersion: nil,
                headerFields: nil
            )!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
