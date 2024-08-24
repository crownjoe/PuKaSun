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
    @State var changeMainView: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if !changeMainView {
                OnboardingView(changeMainView: $changeMainView)
                    .environmentObject(weatherModel)
            }
            else {
                NewView()
                    .environmentObject(weatherModel)
            }
        }
    }
}
