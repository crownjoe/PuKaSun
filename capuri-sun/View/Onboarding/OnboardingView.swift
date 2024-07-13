//
//  OnboardingView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct OnboardingView: View {
    @StateObject private var notificationManager = NotificationManager()
    @StateObject private var locationManager = LocationManager()
    
    @State private var showAdditionalText = false
    @State private var showPukaView = false
    
    @State private var location: CLLocation?
    @State private var address: String = ""
    @State private var uvIndex: String = ""
    @State private var condition: String = ""
    @State private var temperature: String = ""
    @Binding var alarmTime: Double
    
    var body: some View {
        if !showPukaView{
            ZStack {
                Color.backgroundBlue
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 5) {
                    Image("img_onboard")
                    
                    Text("자외선 차단제,")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.top, 40)
                    
                    HStack {
                        Text("주기적으로")
                            .font(.system(size: 30))
                            .foregroundColor(.alarmcolor3)
                            .fontWeight(.bold)
                        Text("덧발라야")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    
                    Text("피부를 지킬 수 있어요!")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                    
                    if showAdditionalText {
                        Rectangle()
                            .frame(width: 312, height: 1)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                            .foregroundColor(.white)
                        Text("자외선 지수를 실시간으로 확인하고,")
                            .font(.system(size: 17))
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        
                        Text("자외선 차단제를 발라야 할 때")
                            .font(.system(size: 17))
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        
                        Text("알려드려요.")
                            .font(.system(size: 17))
                            .foregroundColor(.white)
                            .padding(.bottom, 155)
                    }
                    
                    if !showAdditionalText{
                        
                        Button(action: {
                            showAdditionalText = true
                            
                            locationManager.getCurrentLocation { location in
                                self.location = location
                                self.address = locationManager.address
                                if let location = location {
                                    getWeatherInfo(location)
                                } else {
                                    print("위치 정보를 가져올 수 없습니다.")
                                }
                            }
                        }) {
                            Text("다음")
                                .bold()
                                .font(.system(size: 20))
                                .foregroundColor(.alarmcolor2)
                                .frame(width: 307.96, height: 59)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        
                        .padding(.top, showAdditionalText ? 0 : 320)
                    }
                    else { //두 번 눌렀을 때
                        Button(action: {
                            showPukaView = true
                            
                        }) {
                            Text("다음")
                                .bold()
                                .font(.system(size: 20))
                                .foregroundColor(.alarmcolor2)
                                .frame(width: 307.96, height: 59)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        .padding(.top, showAdditionalText ? 0 : 320)
                    }
                }
                .animation(.default, value: showAdditionalText)
            }.onAppear {
                notificationManager.requestAuthorization()
            }
        }
        else {
            PukaSunView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature, alarmTime: $alarmTime)
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
        case "Partly Cloudy", "Mostly Cloudy", "Cloudy", "Foggy":
            return "흐림"
        case "Clear", "Mostly Clear":
            return "맑음"
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

//#Preview {
//    OnboardingView()
//}
