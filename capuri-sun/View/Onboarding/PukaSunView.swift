//
//  PukaSunView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI
import ActivityKit

//struct PukaSunView: View {
//    var body: some View {
//        ZStack{
//            Color.suncreamPink
//
//            
//        }.ignoresSafeArea(.all)
//    }
//}

import SwiftUI
import SwiftUI

struct ContentView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?

    var body: some View {
        VStack {
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(CustomProgㅇressViewStyle())
                .frame(height: 20)
                .padding()
            
            Spacer()
            
            Button(action: startProgress) {
                Text("Start Progress")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onDisappear {
            // View가 사라질 때 타이머를 정리합니다.
            timer?.invalidate()
        }
    }
    
    func startProgress() {
        progress = 0.0
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if progress < 1.0 {
                withAnimation(.linear(duration: 0.1)) {
                    progress += 0.01
                }
            } else {
                timer?.invalidate()
            }
        }
    }
}

struct CustomProgㅇressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: "#D0D0D0"))
                    .frame(height: 20)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: "#F9A2D7"))
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 20)
                    .animation(.linear, value: configuration.fractionCompleted)
            }
        }
    }
}


#Preview {
    ContentView()
}



