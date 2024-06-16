//
//  WeatherView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherView: View {
    @State private var location: CLLocation? = nil
    
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                if let location = location {
                    getAppleWeather(location)
                } else {
                    //
                }
            }
            .onAppear {
                location = CLLocation(latitude: 36.0190178, longitude: 129.3434808)
            }
    }
    
    
    
    func getAppleWeather(_ location: CLLocation) {
        Task {
            do {
                
                let service = WeatherService()
                let result = try await service.weather(for: location)
                
                let uvIndex = result.currentWeather.uvIndex
                
                print(uvIndex)
                
                print("현재 날씨")
                print(result.currentWeather.temperature)
                print(result.currentWeather.humidity)
                print(result.currentWeather.condition)
                
                guard let hourly = result.hourlyForecast.first else { return }
                print("\n시간별 예보 첫 데이터")
                print(hourly.date)
                print(hourly.condition)
                print(hourly.temperature)
                
                guard let daily = result.dailyForecast.first else { return }
                print("\n주간 예보 첫 데이터")
                print(daily.date)
                print(daily.condition)
                print(daily.highTemperature)
                
            } catch {
                print(String(describing: error))
            }
        }
    }
}

#Preview {
    WeatherView()
}
