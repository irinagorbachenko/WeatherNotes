//
//  Note.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//

import Foundation

struct Note: Identifiable,Decodable,Hashable,Encodable{
    var id: UUID = UUID()
    let title: String
    let createdAt: Date
    let temperature: Double
    let icon: String?
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy,MMM dd HH:mm"
        return formatter.string(from: createdAt)
    }
    
    var formattedTemperature: String {
        String(format: "%.1f C", temperature)
    }
}
