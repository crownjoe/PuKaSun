//
//  AlarmTimeManager.swift
//  capuri-sun
//
//  Created by 조세연 on 6/20/24.
//

import Foundation

public final class AlarmTimeManager: ObservableObject {
    static let shared = AlarmTimeManager()
    private init() { self.alarmTime = alarmTime }
    @Published var alarmTime: Double = 30.0
}
