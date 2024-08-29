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
    @ObservedObject var alarmTimeManager: AlarmTimeManager
    
    @State private var pathModel: PathModel = .init()
    @State private var oneThirdPassed = false
    @State private var twoThirdsPassed = false
    
    @Binding var changeAlarmTime: Bool
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
                    .padding(.leading, 10)
                    .padding(.trailing, 130)
                    
                    UVindexView()
                        .padding(.bottom, -100)
                    
                    pukaiconView(oneThirdPassed: $oneThirdPassed, twoThirdsPassed: $twoThirdsPassed, changeAlarmTime: $changeAlarmTime)
                        .padding(.bottom, 14)
                        .environment(pathModel)
                    
                    mainButtonView(alarmTimeManager: alarmTimeManager, oneThirdPassed: $oneThirdPassed, twoThirdsPassed: $twoThirdsPassed)
                    
                }
                .navigationDestination(for: Path.self) {
                    path in
                    switch path {
                    case.alarmView:
                        AlarmView(changeMainView: $changeMainView, changeAlarmTime: $changeAlarmTime, alarmTimeManager: alarmTimeManager)
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

// TODO: 터치하면 돌아가게
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
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(.customFontBlue)
                }
            }
        }
        .padding(.leading, 194)
    }
}

struct pukaiconView: View {
    @Environment(PathModel.self) var pathModel
    
    @Binding var oneThirdPassed: Bool
    @Binding var twoThirdsPassed: Bool
    @Binding var changeAlarmTime: Bool
    
    var body: some View {
        HStack(spacing: 60) {
            
            if !oneThirdPassed && !twoThirdsPassed {
                Image(.imgMainpuka1)
                    .resizable()
                    .frame(width: 227, height: 422)
            }
            else if oneThirdPassed && !twoThirdsPassed {
                Image(.imgMainpuka2)
                    .resizable()
                    .frame(width: 227, height: 422)
            }
            else {
                Image(.imgMainpuka3)
                    .resizable()
                    .frame(width: 227, height: 422)
            }
            
            buttonView(changeAlarmTime: $changeAlarmTime)
                .environment(pathModel)
            
        }
    }
}

struct buttonView: View {
    @Environment(PathModel.self) var pathModel
        
    @Binding var changeAlarmTime: Bool
    
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
                    changeAlarmTime = true
                }
            Image(.iconSuncream)
                .onTapGesture {
                    pathModel.paths.append(.suncreamView)
                }
        }
    }
}

struct mainButtonView: View {
    @ObservedObject var alarmTimeManager: AlarmTimeManager
    
    @Binding var oneThirdPassed: Bool
    @Binding var twoThirdsPassed: Bool
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            if !alarmTimeManager.ongoingButton && !alarmTimeManager.finishButton {
                outButtonView(alarmTimeManager: alarmTimeManager)
                    .padding(.bottom, 10)
                
                outExplainView()
                    .padding(.bottom, 20)
            }
            else if alarmTimeManager.ongoingButton && !alarmTimeManager.finishButton {
                progressView(alarmTimeManager: alarmTimeManager, oneThirdPassed: $oneThirdPassed, twoThirdsPassed: $twoThirdsPassed)
                    .padding(.bottom, 10)
                
                outEmptyView()
                    .padding(.bottom, 20)
                
            }
            else if !alarmTimeManager.ongoingButton && alarmTimeManager.finishButton {
                endButtonView(alarmTimeManager:alarmTimeManager, oneThirdPassed: $oneThirdPassed, twoThirdsPassed: $twoThirdsPassed)
                    .padding(.bottom, 10)
                
                endExplainView()
                    .padding(.bottom, 20)
            }
        }
    }
}

// MARK: 외출 버튼
// TODO: 그림자 넣기, 알림 주기
struct outButtonView: View {
    
    @ObservedObject var alarmTimeManager: AlarmTimeManager
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 343, height: 92)
                .foregroundColor(.buttonLightBlue)
                .cornerRadius(30)
            
            HStack(alignment: .center) {
                Image(.imgOutbtn)
                    .onTapGesture {
                        alarmTimeManager.ongoingButton = true
                        alarmTimeManager.finishButton = false
                    }
            }
        }
    }
}

// MARK: 진행중 버튼
struct progressView: View {
    @ObservedObject var alarmTimeManager: AlarmTimeManager
    
    @Binding var oneThirdPassed: Bool
    @Binding var twoThirdsPassed: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 343, height: 92)
                .foregroundColor(.buttonBlue)
                .cornerRadius(30)
            
            HStack(spacing: 0) {
                Image(.iconSuncreambtn)
                    .padding(.trailing, 20)
                    .padding(.leading, 86)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(alarmTimeManager.changeTime(alarmTime: Int((((alarmTimeManager.selectedTime ?? 0) * 60) - (alarmTimeManager.progress ?? 0)))) )
                        .font(.system(size: 22))
                        .fontWeight(.heavy)
                        .foregroundColor(.suncreamPink)
                        .padding(.bottom, 1)
                        .padding(.top, 18)
                    
                    Text("후에 자외선 차단제를 발라주세요!")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(.bottom, 4)
                    
                    ProgressView(value: alarmTimeManager.progress ?? 0, total: ((alarmTimeManager.selectedTime ?? 0) * 60))
                        .progressViewStyle(CustomProgressViewStyle())
                        .padding(.bottom, 20)
                }
                .onAppear {
                    let interval = 0.01
                    Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                        if !alarmTimeManager.finishButton && alarmTimeManager.ongoingButton {
                            if (alarmTimeManager.progress ?? 0) < ((alarmTimeManager.selectedTime ?? 0) * 60) {
                                alarmTimeManager.progress = ((alarmTimeManager.progress ?? 0) + (interval))
                                
                                print("🥫🥫🥫🥫🥫",alarmTimeManager.progress ?? 0)
                                print("🎵🎵🎵🎵🎵", (alarmTimeManager.selectedTime) ?? 0)
                                
                                if (alarmTimeManager.progress ?? 0) >= (((alarmTimeManager.selectedTime ?? 0) * 60) / 3) && (alarmTimeManager.progress ?? 0) < (2 * ((alarmTimeManager.selectedTime ?? 0) * 60) / 3) {
                                    print("1🥫🥫🥫🥫🥫",alarmTimeManager.progress ?? 0)
                                    print("1🎵🎵🎵🎵🎵", (alarmTimeManager.selectedTime) ?? 0)
                                    oneThirdPassed = true
                                    twoThirdsPassed = false
                                }
                                
                                else if (alarmTimeManager.progress ?? 0) >= (2 * ((alarmTimeManager.selectedTime ?? 0) * 60) / 3) {
                                    print("2🥫🥫🥫🥫🥫",alarmTimeManager.progress ?? 0)
                                    print("2🎵🎵🎵🎵🎵", (alarmTimeManager.selectedTime) ?? 0)
                                    oneThirdPassed = false
                                    twoThirdsPassed = true
                                }
                                
                            } else {
                                timer.invalidate()
                                alarmTimeManager.ongoingButton = false
                                alarmTimeManager.finishButton = true
                                alarmTimeManager.progress = 0.0
                            }
                        }
                    }
                }
            }
        }
    }
    
    struct CustomProgressViewStyle: ProgressViewStyle {
        func makeBody(configuration: Configuration) -> some View {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.customGray)
                        .frame(width: 203, height: 8)
                    
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.suncreamPink)
                        .frame(width: min(geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), 203), height: 8)
                        .animation(.linear, value: configuration.fractionCompleted)
                }
            }
        }
    }
}


// MARK: 끝난 버튼
struct endButtonView: View {
    
    @ObservedObject var alarmTimeManager: AlarmTimeManager
    
    @Binding var oneThirdPassed: Bool
    @Binding var twoThirdsPassed: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 343, height: 92)
                .foregroundColor(.buttonBlue)
                .cornerRadius(30)
            
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
                    
                    Text("를 바를 시간입니다!")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .onTapGesture {
            alarmTimeManager.ongoingButton = false
            alarmTimeManager.finishButton = false
            oneThirdPassed = false
            twoThirdsPassed = false
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
            
            Text("외출 후 버튼을 눌러 자외선 차단제 알림을 받아보세요!")
                .font(.system(size: 12))
                .fontWeight(.regular)
                .foregroundColor(.white)
        }
    }
}

struct outEmptyView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 286, height: 25)
                .cornerRadius(80)
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
