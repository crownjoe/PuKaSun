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
    
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        
        // TODO: 캐릭터 바뀌게 & 시간 변하게
        
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
                }.padding(.bottom, 30)
                
                VStack{
                    if uvIndex == "1" || uvIndex == "2" {
                        UvView1
                    } else if uvIndex == "3" || uvIndex == "4" || uvIndex == "5" {
                        UvView2
                    } else if uvIndex == "6" || uvIndex == "7" {
                        UvView3
                    } else if uvIndex == "8" || uvIndex == "9" || uvIndex == "10" {
                        UvView4
                    } else {
                        UvView5
                    }
                    
                    Image("img_char1")
                        .padding(.leading, 40)
                    
                    noticeAlarm
                }.padding(.bottom, 30)
                
            }
        }
        
    }
    
    private var UvView1: some View {
        VStack(spacing : 2){
            ZStack{
                Circle()
                    .frame(width: 147, height: 147)
                    .foregroundColor(.uv1)
                
                Text(uvIndex)
                    .fontWeight(.bold)
                    .font(.system(size: 140))
                    .foregroundColor(.suncreamPink)
            }.padding(.leading, 10)
            
            Text("UV 지수")
                .fontWeight(.bold)
                .font(.system(size: 15))
                .foregroundColor(.suncreamPink)
                .padding(.bottom, 2)
            
            Text("낮음")
                .fontWeight(.bold)
                .font(.system(size: 35))
                .foregroundColor(.uv1)
                .padding(.horizontal, 20)
                .background(Color.suncreamBackBlue)
                .cornerRadius(20)
        }
    }
    
    private var UvView2: some View {
        VStack(spacing : 2){
            ZStack{
                Circle()
                    .frame(width: 147, height: 147)
                    .foregroundColor(.uv3)
                
                Text(uvIndex)
                    .fontWeight(.bold)
                    .font(.system(size: 140))
                    .foregroundColor(.uv2)
            }.padding(.leading, 10)
            
            Text("UV 지수")
                .fontWeight(.bold)
                .font(.system(size: 15))
                .foregroundColor(.suncreamPink)
                .padding(.bottom, 2)
            
            Text("보통")
                .fontWeight(.bold)
                .font(.system(size: 35))
                .foregroundColor(.uv2)
                .padding(.horizontal, 20)
                .background(Color.suncreamBackBlue)
                .cornerRadius(20)
        }
    }
    
    private var UvView3: some View {
        VStack(spacing : 2){
            ZStack{
                Circle()
                    .frame(width: 147, height: 147)
                    .foregroundColor(.uv3)
                
                Text(uvIndex)
                    .fontWeight(.bold)
                    .font(.system(size: 140))
                    .foregroundColor(.suncreamPink)
            }.padding(.leading, 10)
            
            Text("UV 지수")
                .fontWeight(.bold)
                .font(.system(size: 15))
                .foregroundColor(.suncreamPink)
                .padding(.bottom, 2)
            
            Text("높음")
                .fontWeight(.bold)
                .font(.system(size: 35))
                .foregroundColor(.suncreamPink)
                .padding(.horizontal, 20)
                .background(Color.suncreamBackBlue)
                .cornerRadius(20)
        }
    }
    
    private var UvView4: some View {
        VStack(spacing : 2){
            ZStack{
                Circle()
                    .frame(width: 147, height: 147)
                    .foregroundColor(.uv4)
    
                Text(uvIndex)
                    .fontWeight(.bold)
                    .font(.system(size: 140))
                    .foregroundColor(.suncreamPink)
            }.padding(.leading, 10)
            
            Text("UV 지수")
                .fontWeight(.bold)
                .font(.system(size: 15))
                .foregroundColor(.suncreamPink)
                .padding(.bottom, 2)
            
            Text("매우높음")
                .fontWeight(.bold)
                .font(.system(size: 35))
                .foregroundColor(.uv4)
                .padding(.horizontal, 20)
                .background(Color.suncreamBackBlue)
                .cornerRadius(20)
        }
    }
    
    private var UvView5: some View {
        VStack(spacing : 2){
            ZStack{
                Circle()
                    .frame(width: 147, height: 147)
                    .foregroundColor(.uv5)
                
                Text(uvIndex)
                    .fontWeight(.bold)
                    .font(.system(size: 140))
                    .foregroundColor(.suncreamPink)
            } .padding(.leading, 10)
            
            Text("UV 지수")
                .fontWeight(.bold)
                .font(.system(size: 15))
                .foregroundColor(.suncreamPink)
                .padding(.bottom, 2)
            
            Text("위험")
                .fontWeight(.bold)
                .font(.system(size: 35))
                .foregroundColor(.uv5)
                .padding(.horizontal, 20)
                .background(Color.suncreamBackBlue)
                .cornerRadius(20)
        }
    }
    
    
    private var noticeAlarm: some View {
        HStack(spacing: 6) {
            Image("img_mainAlarm")
                .frame(width: 90, height: 94)
                .padding(.leading, 10)
            
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text("2시간 00분")
                    .font(.system(size: 26))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.suncreamPink)
                
                
                Text("후에 자외선 차단제를 발라주세요!")
                    .font(.system(size: 13))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 5)
                
                ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(CustomProgressViewStyle())
                    .frame(width: 227, height: 12)
                    .padding(.trailing, 10)
                
            }
        }
        .padding(.vertical, 12)
        .background(Color.mainBlue)
        .cornerRadius(14)
        
    }
    
    struct CustomProgressViewStyle: ProgressViewStyle {
        func makeBody(configuration: Configuration) -> some View {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.98, green: 0.64, blue: 0.84))
                        .cornerRadius(13.5)
                        .frame(width: 227, height: 12)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.81, green: 0.81, blue: 0.81))
                        .cornerRadius(13.5)
                        .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 12)
                        .animation(.linear, value: configuration.fractionCompleted)
                }
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

