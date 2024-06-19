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
    var time: Int
    
    init(time: Int) {
        self.time = time
    }
}
