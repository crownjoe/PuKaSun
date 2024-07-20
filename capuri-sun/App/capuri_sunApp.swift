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
    
    @State private var location: CLLocation?
    @State private var address: String = ""
    @State private var uvIndex: String = ""
    @State private var condition: String = ""
    @State private var temperature: String = ""
    
    var body: some Scene {
        WindowGroup {
            ContorlView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature, location: $location)
        }
    }
}
