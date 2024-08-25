//
//  NewView.swift
//  capuri-sun
//
//  Created by 조세연 on 7/23/24.
//

import SwiftUI
import CoreLocation

struct NewView: View {
    
    @EnvironmentObject var weatherModel: WeatherModel
    
    @State private var pathModel: PathModel = .init()
    
    @Binding var changeMainView: Bool
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            ZStack {
                Image(weatherModel.changeBackground(condition: weatherModel.condition))
                    .resizable()
                    .ignoresSafeArea(.all)
                
                VStack (alignment: .center, spacing: 0) {
                    Spacer()
                    
                    HStack (spacing : 4) {
                        Image(.imgLocation)
                        
                        Text(weatherModel.address)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        
                        Text(weatherModel.condition)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        
                        Text(weatherModel.temperature)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.customBlue)
                    .cornerRadius(20)
                    .padding(.top, 28)
                    .padding(.bottom, 14)
                    .padding(.trailing, 130)
                    
                    UVindexView()
                        .padding(.bottom, -40)
                    
                    pukaiconView()
                        .environment(pathModel)
                    
                    Spacer()
                        .frame(height: 28)
                    
                    mainButtonView()
                    
                    Spacer()
                        .frame(height: 10)
                    
                    outExplainView()
                        .padding(.bottom, 20)
                    
                }
                .navigationDestination(for: Path.self) {
                    path in
                    switch path {
                    case.alarmView:
                        AlarmView(changeMainView: $changeMainView)
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbarRole(.editor)
                    case .suncreamView:
                        SuncreamView()
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbarRole(.editor)
                    case .uvView:
                        UVView()
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbarRole(.editor)
                    }
                }
            }
        }
        .accentColor(.customGray)
        .environment(pathModel)
    }
}

// TODO: 터치하면 돌아가게...

struct UVindexView : View {
    @EnvironmentObject var weatherModel: WeatherModel
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 230)
                .foregroundColor(.customBlue)
            
            VStack(spacing: 0) {
                Text("\(weatherModel.uvIndex)")
                    .font(.system(size: 160))
                    .fontWeight(.bold)
                    .foregroundColor(weatherModel.changeUvColor(uvIndex: weatherModel.uvIndex))
                    .frame(height: 160)
                    .padding(.top, 35)
                    .padding(.bottom, 8)
                
                ZStack {
                    Rectangle()
                        .foregroundColor(weatherModel.changeUvColor(uvIndex: weatherModel.uvIndex))
                        .frame(width: 94, height: 38)
                        .cornerRadius(18)
                    
                    Text(weatherModel.uvIndexDescription)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.customFontBlue)
                }
            }
        }
        .padding(.leading, 194)
    }
}
// TODO: 푸카아이콘 넣기

struct pukaiconView: View {
    @Environment(PathModel.self) var pathModel
    
    var body: some View {
        HStack(spacing: 60) {
            
            Image(.imgMainpuka1)
                .resizable()
                .frame(width: 220, height: 348)
            
            buttonView()
                .environment(pathModel)
            
        }
    }
}

// TODO: 알람뷰 이슈 해결
struct buttonView: View {
    @Environment(PathModel.self) var pathModel
    
    var body: some View {
        VStack(spacing: 35) {
            Spacer()
                .frame(height: 70)
            Image(.iconUv)
                .onTapGesture {
                    pathModel.paths.append(.uvView)
                }
            Image(.iconAlarm)
                .onTapGesture {
                    pathModel.paths.append(.alarmView)
                }
            Image(.iconSuncream)
                .onTapGesture {
                    pathModel.paths.append(.suncreamView)
                }
        }
    }
}

struct mainButtonView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 343, height: 92)
                .foregroundColor(.customBoxBlue)
                .cornerRadius(30)
            
            //            outButtonView()
            progressView()
            //            endButtonView()
            
        }
    }
}

// TODO: 그림자 넣기
struct outButtonView: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(.imgOutbtn)
            // shadow 추가
        }
        
    }
}


struct progressView: View {
    var body: some View {
        HStack(spacing: 0) {
            Image(.iconSuncreambtn)
                .padding(.trailing, 20)
                .padding(.leading, 86)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("2시간 30분")
                    .font(.system(size: 22))
                    .fontWeight(.heavy)
                    .foregroundColor(.suncreamPink)
                    .padding(.bottom, 1)
                
                Text("후에 자외선 차단제를 발라주세요!")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.bottom, 4)
                
                // TODO: 프로그래스 바 추가
            }
            
            Spacer()
        }
    }
}

struct endButtonView: View {
    var body: some View {
        HStack(spacing: 0) {
            Image(.imgEndbtn)
                .padding(.trailing, 21)
                .padding(.leading, 80)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("자외선 차단제")
                    .font(.system(size: 24))
                    .fontWeight(.heavy)
                    .foregroundColor(.suncreamPink)
                    .padding(.bottom, 4)
                
                Text("를 바르실 시간입니다!")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }
}

struct outExplainView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.customExplainBlue)
                .frame(width: 286, height: 25)
                .cornerRadius(80)
            
            Text("외출 후 버튼을 눌러 자외선 자단제 알림을 받아보세요!")
                .font(.system(size: 12))
                .fontWeight(.regular)
                .foregroundColor(.white)
        }
    }
}


struct endExplainView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.customExplainBlue)
                .frame(width: 286, height: 25)
                .cornerRadius(80)
            
            Text("자외선 차단제 버튼을 누르면 푸카가 원상태로 돌아와요!")
                .font(.system(size: 12))
                .fontWeight(.regular)
                .foregroundColor(.white)
        }
    }
}
