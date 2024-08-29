//
//  OnboardingView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct OnboardingView: View {
    @StateObject private var notificationManager = NotificationManager()
    @EnvironmentObject var weatherModel: WeatherModel
    
    @ObservedObject private var locationManager = LocationManager()
    
    @State private var pathModel: PathModel = .init()
    @State private var showAdditionalText = false
    
    @Binding var changeMainView: Bool
    @Binding var changeAlarmTime: Bool
    
    var body: some View {
        NavigationStack(path: $pathModel.onboardingPaths) {
            ZStack {
                Image(.imgDefault)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 0) {
                    Image(.imgOnboard)
                        .padding(.top, 120)
                        .padding(.bottom, 36)
                    
                    Text("자외선 차단제,")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    
                    HStack(spacing: 0) {
                        Text("주기적으로")
                            .font(.system(size: 30))
                            .foregroundColor(.alarmcolor3)
                            .fontWeight(.bold)
                            .padding(.trailing, 10)
                        
                        Text("덧발라야")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.bottom, 8)
                    
                    Text("피부를 지킬 수 있어요!")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 12)
                    
                    if showAdditionalText {
                        VStack(alignment: .leading, spacing: 0) {
                            Rectangle()
                                .frame(width: 312, height: 1)
                                .padding(.bottom, 20)
                                .foregroundColor(.white)
                                .padding(.bottom, 14)
                            
                            Text("자외선 지수를 실시간으로 확인하고,")
                                .font(.system(size: 17))
                                .foregroundColor(.white)
                                .padding(.bottom, 20)
                            
                            Text("자외선 차단제를 발라야 할 때")
                                .font(.system(size: 17))
                                .foregroundColor(.white)
                                .padding(.bottom, 20)
                            
                            Text("알려드려요")
                                .font(.system(size: 17))
                                .foregroundColor(.white)
                                .padding(.bottom, 155)
                            
                        }
                        .frame(height: 320)
                    } else {
                        Spacer()
                            .frame(height: 320)
                    }
                    
                    Button(action: {
                        if showAdditionalText {
                            pathModel.onboardingPaths.append(.pukaSunView)
                        }
                        
                        showAdditionalText = true
                        
                        locationManager.getCurrentLocation { location in
                            self.weatherModel.location = location // 위치 업데이트
                            if let location = location {
                              
                                self.weatherModel.address = locationManager.address
                                weatherModel.getWeatherInfo(location)
                            } else {
                                print("위치 정보를 가져올 수 없습니다.")
                            }
                        }
                    }) {
                        Text("다음")
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(.alarmcolor2)
                            .frame(width: 329, height: 60)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 80)
                    
                }
                .navigationDestination(for: OnboardingPath.self) { path in
                    switch path {
                    case .alarmView:
                        AlarmView(changeMainView: $changeMainView, changeAlarmTime: $changeAlarmTime)
                            .navigationBarBackButtonHidden()
                            .navigationBarHidden(true)
                        
                    case .pukaSunView:
                        PukaSunView()
                            .navigationBarBackButtonHidden()
                            .navigationBarHidden(true)
                    }
                }
                .animation(.default, value: showAdditionalText)
            }.onAppear {
                notificationManager.requestAuthorization()
            }
        }
        .environment(pathModel)
    }
}
