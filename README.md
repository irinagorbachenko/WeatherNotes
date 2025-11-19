WeatherNotes

A lightweight iOS app for creating notes with automatically fetched weather data.

📌 Project Overview

WeatherNotes is a SwiftUI application that allows users to create short notes (e.g., “walk in the park”, “commute to work”, “morning run”) and save them locally.
When a note is created, the app automatically retrieves the current weather from the OpenWeather API.

Each note stores:

text

date and time

air temperature

a weather icon

The app is built using the MVVM architecture, with clearly separated modules: Models, ViewModels, Views, Services, and Storage.

🎯 Key Features
✔️ Notes List Screen

Displays all saved notes, including:

title

creation date/time

temperature

weather icon

Also allows navigation to the details screen.

✔️ Add Note Screen

Includes:

Text input field

Save button

When saving a note:

the current date/time is stored

WeatherService fetches current weather (city: Kyiv)

the result is saved into local storage

loading and error states are handled and displayed

✔️ Note Details Screen

Shows complete information:

note text

date and time

temperature

weather description (clear, rain, cloudy, etc.)

OpenWeather icon

🛠 Technical Implementation
🔸 Architecture: MVVM

Project structure:

WeatherNotes/
 ├── Models/
 ├── ViewModels/
 ├── Views/
 ├── Services/
 ├── Storage/
 ├── WeatherNotesApp.swift

🔸 Networking Layer (WeatherService)

Built on URLSession

Uses URLSessionProtocol for mocking in tests

Handles:

invalid URL

network errors

non-200 status codes

decoding failures

Returns the CurrentWeather model

🔸 Local Storage (NotesStorage)

Stores notes using UserDefaults

Uses Codable

Supports:

add(_ note:)

allNotes

Includes MockNotesStorage for testing.

🔸 ViewModel State & Logic

Example: AddNotesViewModel

Properties:

noteTitle

isLoading

errorMessage

store: NotesStorage

weatherService: WeatherService

The save() method:

calls the weather API

adds the note to storage

manages UI state via @Published

uses @MainActor and defer for proper state cleanup

🧪 Unit Tests

The project includes tests for:

✔️ AddNotesViewModelTests

They verify:

successful note saving

failed API response handling

correct isLoading state transitions

that no note is saved on failure

correct errorMessage values

Mocks included:

MockWeatherService

MockNotesStorage

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

▶️ Running the Project

Open the .xcodeproj or .xcworkspace

Insert your OpenWeather API key

Press Cmd + R to run

The API key is configured inside WeatherService.
