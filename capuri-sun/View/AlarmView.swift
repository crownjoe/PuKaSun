//
//  AlarmView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI

struct AlarmView: View {
    var body: some View {
            Text("자외선 차단제")
            .font(.system(size: 30))
            .bold()
        Text("알림주기를 설정해 주세요")
            .bold()
            .font(.system(size: 30))
        Button(action: {
                            print("Button tapped!")
                        }) {
                            Text("")
                                .font(.system(size: 20)) // 텍스트 크기를 20포인트로 설정
                                .foregroundColor(.white)
                                .frame(width: 307.96, height: 59) // 버튼의 너비와 높이를 설정
                                .background(Color.blue)
                                .cornerRadius(20) // 코너 반경을 20으로 설정
                        }
        Button(action: {
                            print("Button tapped!")
                        }) {
                            Text("")
                                .font(.system(size: 20)) // 텍스트 크기를 20포인트로 설정
                                .foregroundColor(.white)
                                .frame(width: 307.96, height: 59) // 버튼의 너비와 높이를 설정
                                .background(Color.blue)
                                .cornerRadius(20) // 코너 반경을 20으로 설정
                        }
        Button(action: {
                            print("Button tapped!")
                        }) {
                            Text("")
                                .font(.system(size: 20)) // 텍스트 크기를 20포인트로 설정
                                .foregroundColor(.white)
                                .frame(width: 307.96, height: 59) // 버튼의 너비와 높이를 설정
                                .background(Color.blue)
                                .cornerRadius(20) // 코너 반경을 20으로 설정
                        }
        Button(action: {
                            print("Button tapped!")
                        }) {
                            Text("")
                                .font(.system(size: 20)) // 텍스트 크기를 20포인트로 설정
                                .foregroundColor(.white)
                                .frame(width: 307.96, height: 59) // 버튼의 너비와 높이를 설정
                                .background()
                                .cornerRadius(20) // 코너 반경을 20으로 설정
                        }
        
        
        Button(action: {
                            print("Button tapped!")
                        }) {
                            Text("")
                                .font(.system(size: 20)) // 텍스트 크기를 20포인트로 설정
                                .foregroundColor(.white)
                                .frame(width: 307.96, height: 59) // 버튼의 너비와 높이를 설정
                                .background(Color.blue)
                                .cornerRadius(10) // 코너 반경을 20으로 설정
                        }

        }
    }


#Preview {
    AlarmView()
}
