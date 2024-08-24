//
//  ContorlView.swift
//  capuri-sun
//
//  Created by 조세연 on 7/20/24.
//

import SwiftUI
import CoreLocation

struct ContorlView: View {
    
    @ObservedObject private var locationManager = LocationManager()
    @ObservedObject private var alarmTimeManager = AlarmTimeManager()
    
    @Binding var address: String
    @Binding var uvIndex: String
    @Binding var condition: String
    @Binding var temperature: String
    @Binding var location: CLLocation?
    
    var body: some View {
        
        if alarmTimeManager.selectedTime == 0 {
//            OnboardingView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature, location: $location)
            OnboardingView()
                .environmentObject(locationManager)
        }
        else {
            MainView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature, location: $location)
                .environmentObject(locationManager)
        }
    }
}

//#Preview {
//    ContorlView()
//}
