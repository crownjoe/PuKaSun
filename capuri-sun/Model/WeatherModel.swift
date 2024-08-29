//
//  WeatherModel.swift
//  capuri-sun
//
//  Created by 조세연 on 8/25/24.
//

import Foundation
import CoreLocation
import WeatherKit
import SwiftUI

class WeatherModel: ObservableObject {
    @Published var address: String = ""
    @Published var uvIndex: Int = 0
    @Published var uvIndexDescription: String = ""
    @Published var condition: String = ""
    @Published var temperature: String = ""
    @Published var location: CLLocation? = nil
    
    
    /// 날씨 정보 받아오는 함수
    func getWeatherInfo(_ location: CLLocation) {
        Task {
            do {
                let service = WeatherService()
                let result = try await service.weather(for: location)
                
                self.uvIndex = result.currentWeather.uvIndex.value
                self.uvIndexDescription = uvIndexDescription(uvIndex: uvIndex)
                
                let temperatureValue = result.currentWeather.temperature.value
                self.temperature = "\(String(format: "%.1f", temperatureValue))°"
                self.condition = translateCondition(result.currentWeather.condition.description)
                
                print("🥫🥫🥫🥫🥫🥫🥫🥫🥫🥫")
                print("날씨", result.currentWeather.condition.description)
                print("condition", condition)
                print("uvIndexDescription", uvIndexDescription)
                print("uvIndex", uvIndex)
                print("address", address)
                print("temperature", temperature)
                
                
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    /// 날씨 정보 번역
    func translateCondition(_ condition: String) -> String {
        switch condition {
        case "Partly Cloudy", "Mostly Cloudy", "Cloudy", "Foggy", "Haze":
            return "흐림"
        case "Clear", "Mostly Clear":
            return "맑음"
        case "Windy":
            return "바람"
        case "Rain", "Heavy Rain", "Drizzle":
            return "비"
        case "Snow", "Heavy Snow":
            return "눈"
        case "Strongstorm", "Thunderstorm":
            return "뇌우"
        default:
            return condition
        }
    }
    
    /// uvIndex 나누는 함수
    func uvIndexDescription(uvIndex: Int) -> String {
        switch uvIndex {
        case 0...2:
            return "낮음"
        case 3...5:
            return "보통"
        case 6...7:
            return "높음"
        case 8...10:
            return "매우 높음"
        case 11...:
            return "위험"
        default:
            return " "
        }
    }
    
    func changeBackground(condition: String) -> String {
        switch condition {
        case "흐림" :
            return "img_cloud"
        case "맑음" :
            return "img_sun"
        case "바람" :
            return "img_windy"
        case "비" :
            return "img_rain"
        case "눈" :
            return "img_snow"
        case "뇌우" :
            return "img_strongrain"
        default:
            return "img_default"
        }
    }
    
    func changeUvColor(uvIndex: Int) -> Color {
        switch uvIndex {
        case 0...2:
            return .uvLemon
        case 3...5:
            return .uvPink
        case 6...7:
            return .uvMint
        case 8...10:
            return .uvYellow
        case 11...:
            return .uvRed
        default:
            return .uvPink
        }
    }
}
