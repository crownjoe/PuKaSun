//
//  MainView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct MainView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var location: CLLocation?
    @State private var address: String = ""
    @State private var uvIndex: String = ""
    @State private var condition: String = ""
    @State private var temperature: String = ""
    
    var body: some View {
        
        ZStack{
            Image("img_mainBackground")
                .ignoresSafeArea(.all)
            
            VStack{
                HStack(spacing: 20){
                    HStack(spacing: 3){
                        Image("img_location")
                        
                        Text(address)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        
                            .onAppear {
                                locationManager.getCurrentLocation { location in
                                    self.location = location
                                    self.address = locationManager.address
                                    if let location = location {
                                        getWeatherInfo(location)
                                    } else {
                                        print("위치 정보를 가져올 수 없습니다.")
                                    }
                                }
                            }
                        
                        Text(condition)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        
                        Text(temperature)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 12)
                    .background(Color.suncreamBackBlue)
                    .cornerRadius(20)
                    
                    Image("img_alarm")
                    Image("img_suncream")
                    Image("img_uv")
                }
             Spacer()
            
            }
        }
    }
    
    func getWeatherInfo(_ location: CLLocation) {
        Task {
            do {
                let service = WeatherService()
                let result = try await service.weather(for: location)
                
                self.uvIndex = "\(result.currentWeather.uvIndex.value)"
                
                let temperatureValue = result.currentWeather.temperature.value
                self.temperature = "\(String(format: "%.1f", temperatureValue))°"
                
                self.condition = translateCondition(result.currentWeather.condition.description)
                
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func translateCondition(_ condition: String) -> String {
        switch condition {
        case "Partly Cloudy", "Mostly Cloudy", "Cloudy":
            return "흐림"
        case "Clear", "Mostly Clear":
            return "맑음"
        case "Foggy":
            return "안개"
        case "Windy":
            return "바람"
        case "Rain", "Heavy Rain", "Drizzle":
            return "비"
        case "Snow", "Heavy Snow":
            return "눈"
        case "Strong Storms", "Thunder Storms":
            return "뇌우"
        default:
            return condition
        }
    }
}

#Preview {
    MainView()
}

