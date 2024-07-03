//
//  capuri_sunApp.swift
//  capuri-sun
//
//  Created by 조세연 on 6/14/24.
//

import SwiftUI

@main
struct capuri_sunApp: App {
    @State private var alarmTime: Double = 0.0
    
    var body: some Scene { 
        WindowGroup {
            OnboardingView(alarmTime: $alarmTime)
        }
    }
}
