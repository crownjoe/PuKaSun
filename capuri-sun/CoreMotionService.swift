//
//  CoreMotionService.swift
//  capuri-sun
//
//  Created by 조세연 on 6/18/24.
//

import Foundation
import CoreMotion

final class CoreMotionService {
    
    static let shared = CoreMotionService()
    
    private var pedoMeter = CMPedometer()
    
    private init() {
        Timer.scheduledTimer(timeInterval: 3.0,
                             target: self,
                             selector: #selector(checkSteps),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc private func checkSteps() {
        
        let nowDate = Date()
        guard let todayStartDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: nowDate) else {
            return
        }
        
        pedoMeter.queryPedometerData(from: todayStartDate, to: nowDate) { data, error in
            if let error {
                print("CoreMotionService.queryPedometerData Error: \(error)")
                return
            }
            
            if let steps = data?.numberOfSteps {
                DispatchQueue.main.async {
                    print("오늘 걸음 수 \(steps)")
                    
                    if Int(truncating: steps) > 1000 {
                        //라이브 액티비티, timer 시작
                    }
                    else{
                        //
                    }
                }
            }
        }

    }
    
}
