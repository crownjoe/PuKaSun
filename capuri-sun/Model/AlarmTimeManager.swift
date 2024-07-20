//
//  AlarmTimeManager.swift
//  capuri-sun
//
//  Created by 조세연 on 6/20/24.
//

import SwiftUI

class AlarmTimeManager: ObservableObject {
    @Published var selectedTime: Double? {
        didSet {
            UserDefaults.standard.set(selectedTime, forKey: "selectedTime")
        }
    }
    
    @Published var progress: Double? {
        didSet {
            UserDefaults.standard.set(progress, forKey: "progress")
        }
    }

    init() {
        self.selectedTime = UserDefaults.standard.double(forKey: "selectedTime")
        self.progress = UserDefaults.standard.double(forKey: "progress")
    }
}
