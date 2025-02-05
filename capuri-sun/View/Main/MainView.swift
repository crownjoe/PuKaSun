////
////  MainView.swift
////  capuri-sun
////
////  Created by 조세연 on 6/17/24.
////
//
//import SwiftUI
//import ActivityKit
//import CoreLocation
//import WeatherKit
//
//struct MainView: View {
//    
//    @State private var pathModel: PathModel = .init()
//    
//    
//    @StateObject private var notificationManager = NotificationManager()
//    @ObservedObject private var alarmTimeManager = AlarmTimeManager()
//    @ObservedObject private var locationManager = LocationManager()
//    
//    @Binding var address: String
//    @Binding var uvIndex: String
//    @Binding var condition: String
//    @Binding var temperature: String
//    @Binding var location: CLLocation?
//
//
//    @State private var timer: Timer?
//    
//    @State private var startTimer: Bool = false
//    @State private var newTimer: Bool = false
//    @State private var oneThirdPassed = false
//    @State private var twoThirdsPassed = false
//    
//    var body: some View {
//        NavigationStack(path: $pathModel.paths) {
//            ZStack{
//                Image("img_mainBackground")
//                    .resizable()
//                    .ignoresSafeArea(.all)
//                
//                VStack{
//                    HStack(spacing: 20){
//                        HStack(spacing: 3){
//                            Image("img_location")
//                                .frame(width: 30, height: 30)
//                                .padding(.bottom, 4)
//                                .padding(.trailing, -4)
//                            
//                            Text(address)
//                                .font(.system(size: 15))
//                                .foregroundColor(.white)
//                            
//                            Text(condition)
//                                .font(.system(size: 15))
//                                .foregroundColor(.white)
//                            
//                            Text(temperature)
//                                .font(.system(size: 15))
//                                .foregroundColor(.white)
//                        }
//                        .padding(.horizontal, 12)
//                        .background(Color.suncreamBackBlue)
//                        .cornerRadius(20)
//                        
//        
//                   
//                    }.padding(.bottom, 30)
//                    
//                    
//                    VStack{
//                        
//                        if oneThirdPassed && !twoThirdsPassed  {
//                            Image("img_char2")
//                                .frame(width: 148, height: 233)
//                                .padding(.leading, 40)
//                                .padding(.bottom, -20)
//                        }
//                        
//                        else if !oneThirdPassed && twoThirdsPassed {
//                            Image("img_char3")
//                                .frame(width: 148, height: 233)
//                                .padding(.leading, 40)
//                                .padding(.bottom, -20)
//                        }
//                        
//                        else {
//                            Image("img_char1")
//                                .frame(width: 148, height: 233)
//                                .padding(.leading, 40)
//                                .padding(.bottom, -20)
//                        }
//                        
//                        // MARK: - 외출버튼
//                        if !startTimer && alarmTimeManager.progress == 0 {
//                            noticeOutAlarm
//                                .onTapGesture {
//                                    self.startTimer = true
//                                    let alarmTime = alarmTimeManager.selectedTime ?? 0
//                                    notificationManager.makeNotification(alarmTime: TimeInterval(alarmTime))
//                                    //startLivaActivity()
//                                }
//                                .padding(.top, 56)
//                        }
//                        else if startTimer && !newTimer {
//                            noticeAlarm
//                                .padding(.top, 40)
//                        }
//                        else if newTimer && alarmTimeManager.progress == 0 {
//                            noticeFinishAlarm
//                                .padding(.top, 40)
//                        }
//                        else {
//                            noticeAlarm
//                                .padding(.top, 40)
//                        }
//                        
//                    }.padding(.bottom, 20)
//                }
//            }
//        }
//    }
//    
//    
//    // MARK: 외출 버튼
//    private var noticeOutAlarm: some View {
//        ZStack{
//            Image("img_outbackBtn")
//            
//            HStack {
//                Image("img_outBtn")
//                    .frame(width: 90, height: 94)
//                    .padding(.leading, 10)
//                Text("외출")
//                    .font(.system(size: 26))
//                    .fontWeight(.heavy)
//                    .foregroundColor(Color.white)
//                    .padding(.bottom, 5)
//                
//                
//            }.padding(.trailing, 20)
//            
//        }
//    }
//    // MARK: 진행중 버튼
//    private var noticeAlarm: some View {
//        HStack(spacing: 6) {
//            Image("img_mainAlarm")
//                .frame(width: 90, height: 94)
//                .padding(.leading, 10)
//            
//            VStack(alignment: .leading, spacing: 5) {
//                Text(changeTime(alarmTime: Int((((alarmTimeManager.selectedTime ?? 0) * 60) - (alarmTimeManager.progress ?? 0)))) )
//                    .font(.system(size: 26))
//                    .fontWeight(.heavy)
//                    .foregroundColor(Color.suncreamPink)
//                
//                Text("후에 자외선 차단제를 발라주세요!")
//                    .font(.system(size: 13))
//                    .fontWeight(.heavy)
//                    .foregroundColor(Color.white)
//                    .padding(.bottom, 5)
//                
//                ProgressView(value: alarmTimeManager.progress, total: ((alarmTimeManager.selectedTime ?? 0) * 60))
//                    .progressViewStyle(CustomProgressViewStyle())
//                    .frame(width: 227, height: 12)
//                    .padding(.trailing, 10)
//            }
//            .onAppear {
//                let interval = 0.01
//                Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
//                    if (alarmTimeManager.progress ?? 0) < ((alarmTimeManager.selectedTime ?? 0) * 60) {
//                        alarmTimeManager.progress = (alarmTimeManager.progress ?? 0) + (interval / 60)
//                        
//                        if (alarmTimeManager.progress ?? 0) >= (((alarmTimeManager.selectedTime ?? 0) * 60) / 3) && (alarmTimeManager.progress ?? 0) < (2 * ((alarmTimeManager.selectedTime ?? 0) * 60) / 3) {
//                            oneThirdPassed = true
//                            twoThirdsPassed = false
//                        }
//                        
//                        else if (alarmTimeManager.progress ?? 0) >= (2 * ((alarmTimeManager.selectedTime ?? 0) * 60) / 3) {
//                            oneThirdPassed = false
//                            twoThirdsPassed = true
//                        }
//                        
//                    } else {
//                        timer.invalidate()
//                        
//                        self.newTimer = true
//                        alarmTimeManager.progress = 0.0
//                    }
//                }
//            }
//        }
//        .padding(.vertical, 12)
//        .background(Color.mainBlue)
//        .cornerRadius(14)
//        
//    }
//    // MARK: 끝나는 버튼
//    private var noticeFinishAlarm: some View {
//        HStack(spacing: 6) {
//            Image("img_mainAlarm2")
//                .frame(width: 90, height: 94)
//                .padding(.leading, 10)
//                .onTapGesture {
//                    self.newTimer = false
//                    self.oneThirdPassed = false
//                    self.twoThirdsPassed = false
//                    alarmTimeManager.selectedTime = 0
//                }
//            VStack(alignment: .leading, spacing: 5) {
//                
//                Text("자외선 차단제를")
//                    .font(.system(size: 22))
//                    .fontWeight(.heavy)
//                    .foregroundColor(Color.suncreamPink)
//                
//                Text("바르실 시간입니다!")
//                    .font(.system(size: 22))
//                    .fontWeight(.heavy)
//                    .foregroundColor(Color.white)
//                    .padding(.bottom, 5)
//            }
//            Spacer()
//                .frame(width: 64)
//                .foregroundColor(.red)
//        }
//        .padding(.vertical, 12)
//        .background(Color.mainBlue)
//        .cornerRadius(14)
//        
//    }
//    
//    struct CustomProgressViewStyle: ProgressViewStyle {
//        func makeBody(configuration: Configuration) -> some View {
//            GeometryReader { geometry in
//                ZStack(alignment: .leading) {
//                    RoundedRectangle(cornerRadius: 0)
//                        .fill(Color.customGray)
//                        .frame(width: 227, height: 12)
//                    
//                    RoundedRectangle(cornerRadius: 0)
//                        .fill(Color.suncreamPink)
//                        .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 12)
//                        .animation(.linear, value: configuration.fractionCompleted)
//                }
//            }
//        }
//    }
//    
//    func changeTime(alarmTime: Int) -> String {
//        let hours = Int(alarmTime) / 60
//        let minutes = Int(alarmTime) % 60
//        return "\(hours)시간 \(minutes)분"
//    }
//    
//    func getWeatherInfo(_ location: CLLocation) {
//        Task {
//            do {
//                let service = WeatherService()
//                let result = try await service.weather(for: location)
//                
//                self.uvIndex = "\(result.currentWeather.uvIndex.value)"
//                
//                let temperatureValue = result.currentWeather.temperature.value
//                self.temperature = "\(String(format: "%.1f", temperatureValue))°"
//                self.condition = translateCondition(result.currentWeather.condition.description)
//                
//            } catch {
//                print(String(describing: error))
//            }
//        }
//    }
//    
//    func translateCondition(_ condition: String) -> String {
//        switch condition {
//        case "Partly Cloudy", "Mostly Cloudy", "Cloudy", "Foggy":
//            return "흐림"
//        case "Clear", "Mostly Clear":
//            return "맑음"
//        case "Windy":
//            return "바람"
//        case "Rain", "Heavy Rain", "Drizzle":
//            return "비"
//        case "Snow", "Heavy Snow":
//            return "눈"
//        case "Strongstorm", "Thunderstorm":
//            return "뇌우"
//        default:
//            return condition
//        }
//    }
//}
