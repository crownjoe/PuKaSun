//
//  LiveActivityLiveActivity.swift
//  LiveActivity
//
//  Created by 조세연 on 6/18/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var alarmTime: Double
    }
    var name: String
}

struct LiveActivityLiveActivity: Widget {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityAttributes.self) { context in
            
            HStack(spacing: 20) {
                Image("img_LiveActivitySuncream")
                    .frame(width: 90, height: 94)
                    .padding(.leading, 14)
                    
                VStack(alignment: .leading, spacing: 8) {
                    HStack{
                        Image("img_LiveActivitySun")
                            .frame(width: 33, height: 33)
                        
                        Text(changeTime(alarmTime: context.state.alarmTime - progress))
                            .font(.system(size: 26))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 0.98, green: 0.64, blue: 0.84))
                    }
                    
                    Text("후에 자외선 차단제를 발라주세요!")
                        .font(.system(size: 13))
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 0.74, green: 0.74, blue: 0.74))
                        .padding(.bottom, 8)
                    
                    timerView(alarmTime: context.state.alarmTime)
                    
//                                        ProgressView(value: progress, total: context.state.alarmTime)
//                                            .progressViewStyle(CustomProgressViewStyle())
//                                            .frame(width: 227, height: 12)
//                                            .padding(.trailing, 10)
                    
                }
                //                .onAppear {
                //                    let interval = 0.01
                //                    Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                //                        if progress < context.state.alarmTime {
                //                            progress += interval / 60
                //
                //                        } else {
                //                            timer.invalidate()
                //                            self.progress = 0.0
                //                        }
                //                    }
                //                }
            }
            .padding(.vertical, 18)
//            .activityBackgroundTint(Color.white)
            .activitySystemActionForegroundColor(Color(red: 0.74, green: 0.74, blue: 0.74))
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    //다이나믹 터치했을 때
                    Image("img_dynamicicon")
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("얼굴 타는중 🥵")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.98, green: 0.64, blue: 0.84))
                    
                    Text("자외선 차단제를 발라주세요!")
                        .font(.system(size: 15))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .padding(.trailing, 30)
                    
                }
            } compactLeading: {
                Image("img_dynamic")
            } compactTrailing: {
                //                Text("T \(context.state.emoji)")
            } minimal: {
                //                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color(red: 0.98, green: 0.64, blue: 0.84))
        }
    }
}

struct timerView: View {
    @StateObject private var viewModel: TimerViewModel
    
    init(alarmTime: Double) {
        _viewModel = StateObject(wrappedValue: TimerViewModel(alarmTime: alarmTime))
    }
    
    var body: some View {
        VStack {
            ProgressView(value: viewModel.progress, total: viewModel.alarmTime)
                .progressViewStyle(CustomProgressViewStyle())
                .frame(width: 227, height: 12)
                .padding(.trailing, 10)
        }
    }
}


class TimerViewModel: ObservableObject {
    @Published var progress: Double = 0.0
    var alarmTime: Double
    private var timer: Timer?
    
    init(alarmTime: Double) {
        self.alarmTime = alarmTime
        startTimer()
    }
    
    private func startTimer() {
        let interval = 0.01
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.progress < self.alarmTime {
                self.progress += interval / 60
            } else {
                timer.invalidate()
                self.progress = 0.0
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}

func changeTime(alarmTime: Double) -> String {
    let hours = Int(alarmTime) / 60
    let minutes = Int(alarmTime) % 60
    return "\(hours)시간 \(minutes)분"
}

struct CustomProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.81, green: 0.81, blue: 0.81))
                    .cornerRadius(13.5)
                    .frame(width: 227, height: 12)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.98, green: 0.64, blue: 0.84))
                    .cornerRadius(13.5)
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 12)
                    .animation(.linear, value: configuration.fractionCompleted)
            }
        }
    }
}



//extension LiveActivityAttributes {
//    fileprivate static var preview: LiveActivityAttributes {
//        LiveActivityAttributes(name: "World")
//    }
//}
//
//extension LiveActivityAttributes.ContentState {
//    fileprivate static var smiley: LiveActivityAttributes.ContentState {
//        LiveActivityAttributes.ContentState(emoji: "😀")
//    }
//
//    fileprivate static var starEyes: LiveActivityAttributes.ContentState {
//        LiveActivityAttributes.ContentState(emoji: "🤩")
//    }
//}
//
//#Preview("Notification", as: .content, using: LiveActivityAttributes.preview) {
//    LiveActivityLiveActivity()
//} contentStates: {
//    LiveActivityAttributes.ContentState.smiley
//    LiveActivityAttributes.ContentState.starEyes
//}
