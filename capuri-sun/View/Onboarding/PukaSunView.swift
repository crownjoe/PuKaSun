//
//  PukaSunView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI
import CoreLocation

struct PukaSunView: View {
    
    @Environment(PathModel.self) var pathModel
    
    //    @Binding var address: String
    //    @Binding var uvIndex: String
    //    @Binding var condition: String
    //    @Binding var temperature: String
    //    @Binding var location: CLLocation?
    
    
    var body: some View {
        ZStack {
            Color.suncreamPink
                .ignoresSafeArea(.all)
            
            VStack(spacing:0) {
                Image("img_puka")
                
                // TODO: 패딩 조절
                    .padding(.top, 219)
                    .padding(.bottom, 72)
                
                Image("img_puka1")
                    .padding(.bottom, 16)
                
                Text(" Weather")
                    .fontWeight(.regular)
                    .font(.system(size: 20))
                    .padding(.bottom, 48)
                    .onTapGesture {
                        if let url = URL(string: "https://developer.apple.com/weatherkit/data-source-attribution/") {
                            UIApplication.shared.open(url)
                        }
                    }
                
                Text("자외선 걱정 없이 외출하세요!")
                    .font(.system(size: 20))
                    .foregroundColor(.pukacolor)
                    .fontWeight(.bold)
                    .padding(.bottom, 114)
                
                Button(action: {
                    pathModel.onboardingPaths.append(.alarmView)
                    
                }) {
                    Text("다음")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.alarmcolor2)
                        .frame(width: 329, height: 60)
                        .background(Color.pukacolor)
                        .cornerRadius(10)
                }
                .padding(.bottom, 80)
                
            }
            .ignoresSafeArea(.all)
        }
    }
}

//#Preview {
//    PukaSunView()
//}
