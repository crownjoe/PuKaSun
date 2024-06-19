//
//  MainView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI
import CoreLocation
import WeatherKit
import ActivityKit

struct MainView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var location: CLLocation?
    @State private var address: String = ""
    @State private var uvIndex: String = ""
    @State private var condition: String = ""
    @State private var temperature: String = ""
    
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    
    @State private var startTimer: Bool = false
    @State private var newTimer: Bool = false
    
    //    @Query var alarms: [Alarm]
    
    @AppStorage("alarmTime") var alarmTime: Double = 0.2
    
    
    var body: some View {
        // TODO: 캐릭터 바뀌게 & 시간 변하게
        
        ZStack{
            Image("img_mainBackground")
                .resizable()
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
                    
                    // TODO: 캐릭터 바뀌게
                    
                    Image("img_char1")
                        .padding(.leading, 40)
                    
                    if !startTimer { // TODO: 다음날 외출 버튼이 떠야함!
                        noticeOutAlarm
                            .onTapGesture {
                                self.startTimer = true
                                startLivaActivity()
                            }
                    }
                    else if startTimer && !newTimer{
                        noticeAlarm
                    }
                    else if newTimer {
                        noticeFinishAlarm
                    }
                    
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
    
    // MARK: 외출 버튼
    private var noticeOutAlarm: some View {
        ZStack{
            Image("img_outbackBtn")
            
            HStack {
                Image("img_outBtn")
                    .frame(width: 90, height: 94)
                    .padding(.leading, 10)
                
                
                Text("외출")
                    .font(.system(size: 26))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 5)
                
                
            }.padding(.trailing, 20)
            
        }
    }
    
    private var noticeAlarm: some View {
        HStack(spacing: 6) {
            Image("img_mainAlarm")
                .frame(width: 90, height: 94)
                .padding(.leading, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(changeTime(alarmTime: alarmTime))
                    .font(.system(size: 26))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.suncreamPink)
                
                Text("후에 자외선 차단제를 발라주세요!")
                    .font(.system(size: 13))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 5)
                
                ProgressView(value: progress, total: alarmTime)
                    .progressViewStyle(CustomProgressViewStyle())
                    .frame(width: 227, height: 12)
                    .padding(.trailing, 10)
            }
            .onAppear{
                let interval = 1.0
                Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                    if progress < alarmTime {
                        progress += interval / 60
                    } else {
                        timer.invalidate()
                        self.newTimer = true
                        self.progress = 0.0
                    }
                }
            }
        }
        .padding(.vertical, 12)
        .background(Color.mainBlue)
        .cornerRadius(14)
        
    }
    
    // MARK: 끝나는 버튼
    private var noticeFinishAlarm: some View {
        HStack(spacing: 6) {
            Image("img_mainAlarm2")
                .frame(width: 90, height: 94)
                .padding(.leading, 10)
                .onTapGesture {
                    self.newTimer = false
                }
            VStack(alignment: .leading, spacing: 5) {
                
                Text("자외선 차단제를")
                    .font(.system(size: 22))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.suncreamPink)
                
                Text("바르실 시간입니다!")
                    .font(.system(size: 22))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 5)
            }
            Spacer()
                .frame(width: 64)
                .foregroundColor(.red)
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
                        .fill(Color.customGray)
                        .cornerRadius(13.5)
                        .frame(width: 227, height: 12)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.suncreamPink)
                        .cornerRadius(13.5)
                        .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 12)
                        .animation(.linear, value: configuration.fractionCompleted)
                }
            }
        }
    }
    
    func startLivaActivity() {
        let liveActivityAttributes = LiveActivityAttributes(name: "pukaSun")
        let contentState = LiveActivityAttributes.ContentState(emoji: "7")
        
        do {
            let activity = try Activity<LiveActivityAttributes>.request(
                attributes: liveActivityAttributes,
                contentState: contentState
            )
            print(activity)
        } catch {
            print(error)
        }
    }
    
    
    func changeTime(alarmTime: Double) -> String {
        let hours = Int(alarmTime) / 60
        let minutes = Int(alarmTime) % 60
        return "\(hours)시간 \(minutes)분"
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

