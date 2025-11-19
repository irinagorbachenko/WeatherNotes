WeatherNotes

A lightweight iOS app for creating notes with automatically fetched weather data.

📌 Project Overview

WeatherNotes is a SwiftUI application that allows users to create short notes (e.g., “walk in the park”, “commute to work”, “morning run”) and save them locally.
When a note is created, the app automatically retrieves the current weather from the OpenWeather API.

🌐 API

Uses OpenWeather Current Weather Data:

https://api.openweathermap.org/data/2.5/weather?q=Kyiv&appid=YOUR_API_KEY&units=metric

🧩 Technologies Used

Swift 5

SwiftUI

MVVM

URLSession

Codable

UserDefaults storage

Async/Await

XCTest (Unit Tests)

🧭 GitFlow

Main branch:

main


Feature branches:

feature/add-note  

feature/list-screen

feature/weather-service

feature/details-screen

feature/HotFix

feature/Fix
