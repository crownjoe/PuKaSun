//
//  PukaSunView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI
import ActivityKit

struct PukaSunView: View {
    var body: some View {
        
        Button("Start") {
            let liveActivityAttributes = LiveActivityAttributes(name: "test")
            let contentState = LiveActivityAttributes.ContentState(emoji: "7")
              
              do {
                let activity = try Activity<LiveActivityAttributes>.request(
                  attributes: liveActivityAttributes,
                  contentState: contentState
                )
                print(activity)
              } catch {
                print(error)
              }
            }
          }
        }
//        ZStack{
//            Color.suncreamPink
//            
//            
//            
//        }.ignoresSafeArea(.all)
//    }
//}

#Preview {
    PukaSunView()
}



