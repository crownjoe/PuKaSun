//
//  MainView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI
import ActivityKit
import UserNotifications

struct MainView: View {
    let manager = NotificationManager.instance
    
    @Binding var address: String
    @Binding var uvIndex: String
    @Binding var condition: String
    @Binding var temperature: String
    @Binding var alarmTime: Double
    
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    
    @State private var startTimer: Bool = false
    @State private var newTimer: Bool = false
    
    @State private var oneThirdPassed = false
    @State private var twoThirdsPassed = false
    
    //@Query var alarms: [Alarm]
    //@AppStorage("alarmTime") var alarmTime: Double = 0.2

    
    var body: some View {
        NavigationStack {
            ZStack{
                Image("img_mainBackground")
                    .resizable()
                    .ignoresSafeArea(.all)
                
                VStack{
                    HStack(spacing: 20){
                        HStack(spacing: 3){
                            Image("img_location")
                                .frame(width: 30, height: 30)
                                .padding(.bottom, 4)
                                .padding(.trailing, -4)
                            
                            Text(address)
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                            
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
                        
                        NavigationLink(destination: AlarmView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature)){
                            Image("img_alarm")
                        }
                        
                        NavigationLink(destination: SuncreamView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature, alarmTime: $alarmTime)){
                            Image("img_suncream")
                        }
                        
                        NavigationLink(destination: UVView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature, alarmTime: $alarmTime)){
                            Image("img_uv")
                        }
                        
                    }.padding(.bottom, 30)
                    
                    
                    VStack{
                        if uvIndex == "0" || uvIndex == "1" || uvIndex == "2" {
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
                        
                        if oneThirdPassed && !twoThirdsPassed  {
                            Image("img_char2")
                                .frame(width: 148, height: 233)
                                .padding(.leading, 40)
                                .padding(.bottom, -20)
                        }
                        
                        else if !oneThirdPassed && twoThirdsPassed {
                            Image("img_char3")
                                .frame(width: 148, height: 233)
                                .padding(.leading, 40)
                                .padding(.bottom, -20)
                        }
                        
                        else {
                            Image("img_char1")
                                .frame(width: 148, height: 233)
                                .padding(.leading, 40)
                                .padding(.bottom, -20)
                        }
                        
                        if !startTimer { // TODO: 다음날 외출 버튼이 떠야함! & 알림 여기서 시작
                            noticeOutAlarm
                                .onTapGesture {
                                    print("메인뷰", alarmTime)
                                    self.startTimer = true
                                    manager.makeNotification(alarmTime: alarmTime)
                                    //startLivaActivity()
                                }
                                .padding(.top, 56)
                                .onAppear {
                                    manager.requestAuthorization()
                                }
                        }
                        else if startTimer && !newTimer{
                            noticeAlarm
                                .padding(.top, 40)
                        }
                        else if newTimer {
                            noticeFinishAlarm
                                .padding(.top, 40)
                        }
                        
                    }.padding(.bottom, 20)
                }
            }
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
               
        }
        .edgesIgnoringSafeArea(.all)
        .tint(Color.customGray)
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
    // MARK: 진행중 버튼
    private var noticeAlarm: some View {
        HStack(spacing: 6) {
            Image("img_mainAlarm")
                .frame(width: 90, height: 94)
                .padding(.leading, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(changeTime(alarmTime: (alarmTime - progress)) )
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
            .onAppear {
                let interval = 0.01
                Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                    if progress < alarmTime {
                        progress += interval / 60
                        
                        if progress >= (alarmTime / 3) && progress < (2 * alarmTime / 3) {
                            oneThirdPassed = true
                            twoThirdsPassed = false
                        }
                        
                        else if progress >= (2 * alarmTime / 3) {
                            oneThirdPassed = false
                            twoThirdsPassed = true
                        }
                        
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
                    self.oneThirdPassed = false
                    self.twoThirdsPassed = false
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
    
    class NotificationManager {
        static let instance = NotificationManager()
        private init() {}
        
        func requestAuthorization() {
            let options: UNAuthorizationOptions = [.alert, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("성공")
                }
            }
        }
        
        func makeNotification(alarmTime : TimeInterval) {
            let content = UNMutableNotificationContent()
            content.title = "설정한 시간이 지났습니다"
            content.subtitle = "얼굴 타는중🥵 자외선 차단제를 다시 발라주세요!"
            content.sound = .default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (alarmTime * 60), repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("알림 설정 성공")
                }
            }
        }
        
//        func cancelNotification() {
//            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        }
    }
    
    func startLivaActivity() {
        let liveActivityAttributes = LiveActivityAttributes(name: "pukaSun")
        let contentState = LiveActivityAttributes.ContentState(alarmTime: alarmTime)
        
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
    
}



