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
    @ObservedObject private var alarmTimeManager = AlarmTimeManager()
    
    @State var changeMainView: Bool = false
    @State var changeAlarmTime: Bool = false
    
    var body: some Scene {
        WindowGroup {
            
            if !changeMainView {
                OnboardingView(alarmTimeManager: alarmTimeManager, changeMainView: $changeMainView, changeAlarmTime: $changeAlarmTime)
                    .environmentObject(weatherModel)
            }
            else {
                NewView(alarmTimeManager: alarmTimeManager, changeAlarmTime: $changeAlarmTime, changeMainView: $changeMainView)
                    .environmentObject(weatherModel)
            }
        }
    }
}
