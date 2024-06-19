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
        //변하는 값 -> 시간 
        var emoji: String
    }
    
    // 안변하는 값
    var name: String
}

struct LiveActivityLiveActivity: Widget {
    
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            
            HStack(spacing: 20) {
                Image("img_LiveActivitySuncream")
                    .frame(width: 90, height: 94)
                    .padding(.leading, 14)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack{
                        Image("img_LiveActivitySun")
                            .frame(width: 33, height: 33)
                        
                        Text("2시간 00분")
                            .font(.system(size: 26))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 0.98, green: 0.64, blue: 0.84))
                        
                    }
                    
                    Text("후에 자외선 차단제를 발라주세요!")
                        .font(.system(size: 13))
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 0.74, green: 0.74, blue: 0.74))
                        .padding(.bottom, 8)
                    
                    
                    ProgressView(value: progress, total: 1.0)
                        .progressViewStyle(CustomProgressViewStyle())
                        .frame(width: 227, height: 12)
                        .padding(.trailing, 10)
                    
                }
            }
            .padding(.vertical, 18)
            .activityBackgroundTint(Color.white)
            .activitySystemActionForegroundColor(Color(red: 0.74, green: 0.74, blue: 0.74))
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    //다이나믹 터치했을 때
                    
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Image("img_dynamic")
            } compactTrailing: {
//                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

struct CustomProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.98, green: 0.64, blue: 0.84))
                    .cornerRadius(13.5)
                    .frame(width: 227, height: 12)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.81, green: 0.81, blue: 0.81))
                    .cornerRadius(13.5)
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 12)
                    .animation(.linear, value: configuration.fractionCompleted)
            }
        }
    }
}


extension LiveActivityAttributes {
    fileprivate static var preview: LiveActivityAttributes {
        LiveActivityAttributes(name: "World")
    }
}

extension LiveActivityAttributes.ContentState {
    fileprivate static var smiley: LiveActivityAttributes.ContentState {
        LiveActivityAttributes.ContentState(emoji: "😀")
    }
    
    fileprivate static var starEyes: LiveActivityAttributes.ContentState {
        LiveActivityAttributes.ContentState(emoji: "🤩")
    }
}

#Preview("Notification", as: .content, using: LiveActivityAttributes.preview) {
    LiveActivityLiveActivity()
} contentStates: {
    LiveActivityAttributes.ContentState.smiley
    LiveActivityAttributes.ContentState.starEyes
}
