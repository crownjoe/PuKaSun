import SwiftUI
import WeatherKit
import CoreLocation

struct AlarmView: View {
    @Binding var address: String
    @Binding var uvIndex: String
    @Binding var condition: String
    @Binding var temperature: String
    
    @State private var showPicker = false
    @State private var showMainView = false
    @State private var selectedHour: Int = 0
    @State private var isClicked: Bool = false
    
    @ObservedObject private var alarmTimeManager = AlarmTimeManager.shared
    
    @State private var selectedButton: Int? = nil
    
    let timeRange = 4..<9
    
    var body: some View {
        if !showMainView{
            ZStack {
                Image("img_alarmBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("자외선 차단제")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                        .padding(.top, 100)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    HStack(spacing: 0) {
                        Text("알림주기")
                            .bold()
                            .font(.system(size: 30))
                            .foregroundColor(.alarmcolor3)
                            .fontWeight(.bold)
                            .padding(.leading, 20)
                        Text("를 설정해 주세요")
                            .bold()
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.bottom, 80)
                    
                    // MARK: 2시간마다
                    VStack(spacing: 22) {
                        ZStack {
                            Color.alarmcolor
                                .frame(width: 308, height: 60)
                                .cornerRadius(20)
                            
                            HStack {
                                Button(action: {
                                    selectedHour = 2
                                    connectData()
//                                    selectedHour = 0
//                                    isClicked.toggle() // 버튼 클릭 상태 변경
                                })
                                {
                                    HStack {
                                        
                                        Text("2시간마다")
                                            .fontWeight(.bold)
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                        
                                        Text("권장")
                                            .fontWeight(.bold)
                                            .foregroundColor(.alarmcolor3)
                                            .frame(width: 49, height: 28)
                                            .background(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .fill(Color.alarmcolor4)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke(Color.alarmcolor5, lineWidth: 2)
                                                    )
                                            )
                                    }
                                }
                                
                                //                                {
                                //
                                //                                    Button(action: {
                                //                                        selectedHour = 2
                                //                                        connectData()
                                //                                        selectedHour = 0
                                //                                    }) {
                                //                                        Text("2시간마다")
                                //                                            .fontWeight(.bold)
                                //                                            .font(.system(size: 20))
                                //                                            .foregroundColor(.white)
                                //
                                //                                        Text("권장")
                                //                                            .fontWeight(.bold)
                                //                                            .foregroundColor(.alarmcolor3)
                                //                                            .frame(width: 49, height: 28)
                                //                                            .background(
                                //                                                RoundedRectangle(cornerRadius: 20)
                                //                                                    .fill(Color.alarmcolor4)
                                //                                                    .overlay(
                                //                                                        RoundedRectangle(cornerRadius: 20)
                                //                                                            .stroke(Color.alarmcolor5, lineWidth: 2)
                                //                                                    )
                                //                                            )
                                //                                    }
                                //                                }
                                
                                
                            }
                        } 
                        .overlay(
                            selectedHour == 2 ?
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.suncreamPink, lineWidth: 4)
                            : nil
                        )

                        // MARK: 3시간마다
                        Button(action: {
                            selectedHour = 3
                            connectData()
//                            selectedHour = 0
                        }) {
                            Text("3시간마다")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 308, height: 60)
                                .background(Color.alarmcolor)
                                .cornerRadius(20)
                        }.overlay(
                            selectedHour == 3 ?
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.suncreamPink, lineWidth: 4)
                            : nil
                        )
                        
                        VStack {
                            // MARK: _시간마다
                            Button(action: {
                                showPicker.toggle()
                            }) {
                                Text("\(0...3 ~= selectedHour  ?  "_시간마다" : "\(selectedHour)시간마다")")
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .frame(width: 308, height: 60)
                                    .background(Color.alarmcolor)
                                    .cornerRadius(20)
//                                    .padding(.bottom, 22)
                            }
                            .overlay(
                                (selectedHour == 4 || selectedHour == 5 || selectedHour == 6 || selectedHour == 7 || selectedHour == 8) ?
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.suncreamPink, lineWidth: 4)
                                : nil
                            )

                            .sheet(isPresented: $showPicker) {
                                VStack {
                                    Picker("시간", selection: $selectedHour) {
                                        ForEach(timeRange, id: \.self) { hour in
                                            Text("\(hour)").tag(hour as Int?)
                                        }
                                    }
                                    .onAppear{
                                        if selectedHour == nil {
                                            selectedHour = timeRange.first ?? selectedHour
                                        }
                                        if (selectedHour != 0), 0...3 ~= selectedHour {
                                            self.selectedHour = timeRange.first ?? selectedHour
                                        }
                                    }
                                    
                                    .presentationDragIndicator(.visible)
                                    .pickerStyle(WheelPickerStyle())
                                    .padding()
                                    
                                    Button("완료") {
                                        selectedHour = selectedHour
                                        showPicker.toggle()
                                        connectData()
                                    }
                                    
                                }.presentationDetents([.height(280)])
                                
                            }
                            
                            Button(action: {
                                self.showMainView = true
                            }) {
                                Text("시작하기")
                                    .bold()
                                    .font(.system(size: 20))
//                                    .foregroundColor(.alarmcolor2)
                                    .foregroundColor((1...8).contains(selectedHour) ? .alarmcolor2 : .gray)
                                    .frame(width: 308, height: 60)
//                                    .background(Color.white)
                                    .background((1...8).contains(selectedHour) ? .white : .customGray)
                                    .cornerRadius(10)
                            }
                            .disabled(!(1...8).contains(selectedHour))
                            .padding(.bottom, 80)
                            .padding()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        else {
            MainView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature, alarmTime: $alarmTimeManager.alarmTime)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
    
    func connectData() {
        let hour = selectedHour ?? 0
        alarmTimeManager.alarmTime = Double(hour * 60)
    }
}

//#Preview {
//    AlarmView()
//}
