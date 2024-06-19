//
//  OnboardingView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var showAdditionalText = false // 상태 변수 선언

    var body: some View {
        ZStack {
            Color.backgroundBlue
                .ignoresSafeArea(.all)

            VStack(alignment: .leading, spacing: 5) {
                Image("img_onboard")

                Text("자외선 차단제,")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top, 40)

                HStack {
                    Text("주기적으로")
                        .font(.system(size: 30))
                        .foregroundColor(.alarmcolor3)
                        .fontWeight(.bold)
                    Text("덧발라야")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }

                Text("피부를 지킬 수 있어요!")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .fontWeight(.bold)

                Rectangle()
                    .frame(width: 312, height: 1)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    .foregroundColor(.white)

                // 이곳에 showAdditionalText가 true일 때 나타나는 텍스트를 추가합니다.
                if showAdditionalText {
                    Text("자외선 지수를 실시간으로 확인하고,")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    Text("자외선 차단제를 발라야 할 때")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    Text("알려드려요.")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 155)
                }

                Button(action: {
                    showAdditionalText = true // 버튼이 눌릴 때 상태 변수를 true로 설정
                }) {
                    Text("다음")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.alarmcolor2)
                        .frame(width: 307.96, height: 59)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding(.top, showAdditionalText ? 0 : 155) // 추가 텍스트가 없을 때의 공간 유지
            }
        }
    }
}

#Preview {
    OnboardingView()
}
