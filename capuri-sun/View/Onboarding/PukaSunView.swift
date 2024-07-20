//
//  PukaSunView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI
import CoreLocation

struct PukaSunView: View {
    
    @Binding var address: String
    @Binding var uvIndex: String
    @Binding var condition: String
    @Binding var temperature: String
    @Binding var location: CLLocation?
    
    @State private var showAlarmView = false
    
    var body: some View {
        if !showAlarmView{
            ZStack{
                Color.suncreamPink
                    .ignoresSafeArea(.all)
                VStack{
                    Image("img_puka")
                        .padding(.top, 219)
                    
                    Image("img_puka1")
                        .padding(.top, 38)
                        .padding(.bottom, 18)
                    
                    Text(" Weather")
                        .fontWeight(.regular)
                        .font(.system(size: 20))
                        .onTapGesture {
                            if let url = URL(string: "https://developer.apple.com/weatherkit/data-source-attribution/") {
                                UIApplication.shared.open(url)
                            }
                        }
                    
                    Text("자외선 걱정 없이 외출하세요! ")
                        .font(.system(size: 20))
                        .foregroundColor(.pukacolor)
                        .padding(.bottom, 155)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.bottom, -40)
                    
                    Button(action: {
                        self.showAlarmView = true
                        
                    }) {
                        Text("다음")
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(.alarmcolor2)
                            .frame(width: 308, height: 60)
                            .background(Color.pukacolor)
                            .cornerRadius(10)
                    }
                    
                }
                .ignoresSafeArea(.all)
            }
        }
        else {
            AlarmView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature, location: $location)
        }
    }
}

//#Preview {
//    PukaSunView()
//}



