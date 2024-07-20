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

    init() {
        self.selectedTime = UserDefaults.standard.double(forKey: "selectedTime")
    }
}
