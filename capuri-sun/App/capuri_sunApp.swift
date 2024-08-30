//
//  capuri_sunApp.swift
//  capuri-sun
//
//  Created by 조세연 on 6/14/24.
//

import SwiftUI
import CoreLocation

@main
struct capuri_sunApp: App {
    
    @StateObject private var weatherModel = WeatherModel()
    @StateObject private var notificationManager = NotificationManager()
    
    @ObservedObject private var alarmTimeManager = AlarmTimeManager()
    
    @State var changeMainView: Bool = false
    @State var changeAlarmTime: Bool = false
    
    // TODO: 웨더킷 호출
    var body: some Scene {
        WindowGroup {
            if !changeMainView {
                OnboardingView(alarmTimeManager: alarmTimeManager, changeMainView: $changeMainView, changeAlarmTime: $changeAlarmTime)
                    .environmentObject(weatherModel)
                    .environmentObject(notificationManager)
            }
            else {
                NewView(alarmTimeManager: alarmTimeManager, changeAlarmTime: $changeAlarmTime, changeMainView: $changeMainView)
                    .environmentObject(weatherModel)
                    .environmentObject(notificationManager)
            }
        }
    }
}
