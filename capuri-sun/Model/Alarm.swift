//
//  AlarmModel.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import Foundation
import SwiftData

@Model
class Alarm {
    var time: Double = 10.0
    
    init(time: Int) {
        self.time = Double(time)
    }
}
