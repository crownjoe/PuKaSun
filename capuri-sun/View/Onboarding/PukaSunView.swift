//
//  PukaSunView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI

struct PukaSunView: View {
    var body: some View {
        ZStack{
            Color.suncreamPink
                .ignoresSafeArea(.all)
            VStack{
                Image("img_puka")
                    .padding(.top, 219)
                
                Image("img_puka1")
                    .padding(.top, 38)
                
                
                Text("자외선 걱정 없이 외출하세요! ")
                    .font(.system(size: 20))
                    .foregroundColor(.pukacolor)
                    .padding(.bottom, 155)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Button(action: {
                    print("Button tapped!")
                }) {
                    Text("다음")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.alarmcolor2)
                        .frame(width: 307.96, height: 59)
                        .background(Color.pukacolor)
                        .cornerRadius(10)
                }
                
                
            }
            .ignoresSafeArea(.all)
        }
    }
}
#Preview {
    PukaSunView()
}



