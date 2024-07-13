//
//  NotificationManager.swift
//  capuri-sun
//
//  Created by 조세연 on 7/6/24.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("성공")
            }
        }
    }
    
    func makeNotification(alarmTime : TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "설정한 시간이 지났습니다"
        content.subtitle = "얼굴 타는중🥵 자외선 차단제를 다시 발라주세요!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (alarmTime * 60), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("알림 설정 성공")
            }
        }
    }
}
