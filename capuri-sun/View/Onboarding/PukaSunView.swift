//
//  PukaSunView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct PukaSunView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var location: CLLocation?
    @State private var address: String = ""
    @State private var uvIndex: String = ""
    @State private var condition: String = ""
    @State private var temperature: String = ""
    
    
    
    @State private var showAlarmView = false
    
    var body: some View {
        if !showAlarmView{
            ZStack{
                Color.suncreamPink
                    .ignoresSafeArea(.all)
                VStack{
                    Image("img_puka")
                        .padding(.top, 219)
                    
                    Image("img_puka1")
                        .padding(.top, 38)
                    
                    
                    Text("자외선 걱정 없이 외출하세요! ")
                        .font(.system(size: 20))
                        .foregroundColor(.pukacolor)
                        .padding(.bottom, 155)
                        .fontWeight(.bold)
                        .padding(.top, 40)
                    
                    Button(action: {
                        locationManager.getCurrentLocation { location in
                            self.location = location
                            self.address = locationManager.address
                            if let location = location {
                                getWeatherInfo(location)
                            } else {
                                print("위치 정보를 가져올 수 없습니다.")
                            }
                        }
                        
                        self.showAlarmView = true
                        
                    }) {
                        Text("다음")
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(.alarmcolor2)
                            .frame(width: 307.96, height: 59)
                            .background(Color.pukacolor)
                            .cornerRadius(10)
                    }
                    
                    
                }
                .ignoresSafeArea(.all)
            }
        }
        else {
            AlarmView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature)
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
    PukaSunView()
}



