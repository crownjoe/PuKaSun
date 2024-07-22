import SwiftUI
import CoreLocation

struct AlarmView: View {
    @Binding var address: String
    @Binding var uvIndex: String
    @Binding var condition: String
    @Binding var temperature: String
    @Binding var location: CLLocation?
    
    @State private var showPicker = false
    @State private var showMainView = false
    @State private var selectedHour: Int = 0
    @State private var isClicked: Bool = false
    @State private var selectedButton: Int? = nil
    
    @ObservedObject private var alarmTimeManager = AlarmTimeManager()
    
    let timeRange = 5..<9
    
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
                    
                    // MARK: - 2시간마다
                    VStack(spacing: 22) {
                        ZStack {
                            Color.alarmcolor
                                .frame(width: 308, height: 60)
                                .cornerRadius(20)
                            
                            HStack {
                                Button(action: {
                                    alarmTimeManager.selectedTime = 2
                                    alarmTimeManager.progress = 0
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
                            }
                        }
                        .overlay(
                            alarmTimeManager.selectedTime == 2 ?
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.suncreamPink, lineWidth: 4)
                            : nil
                        )
                        
                        // MARK: - 3시간마다
                        Button(action: {
                            alarmTimeManager.selectedTime = 3
                            alarmTimeManager.progress = 0
                        }) {
                            Text("3시간마다")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 308, height: 60)
                                .background(Color.alarmcolor)
                                .cornerRadius(20)
                        }.overlay(
                            alarmTimeManager.selectedTime == 3 ?
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.suncreamPink, lineWidth: 4)
                            : nil
                        )
                        
                        // MARK: - 4시간마다
                        Button(action: {
                            alarmTimeManager.selectedTime = 4
                            alarmTimeManager.progress = 0
                        }) {
                            Text("4시간마다")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 308, height: 60)
                                .background(Color.alarmcolor)
                                .cornerRadius(20)
                        }.overlay(
                            alarmTimeManager.selectedTime == 4 ?
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.suncreamPink, lineWidth: 4)
                            : nil
                        )
                        
                        VStack {
                            // MARK: - _시간마다
                            Button(action: {
                                showPicker.toggle()
                            }) {
                                Text("\(0...4 ~= (alarmTimeManager.selectedTime ?? 0) ? "_시간마다" : "\(Int(alarmTimeManager.selectedTime ?? 0))시간마다")")
                                
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .frame(width: 308, height: 60)
                                    .background(Color.alarmcolor)
                                    .cornerRadius(20)
                            }
                            .overlay(
                                (alarmTimeManager.selectedTime == 5 || alarmTimeManager.selectedTime == 6 || alarmTimeManager.selectedTime == 7 || alarmTimeManager.selectedTime == 8) ?
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
                                        if (selectedHour != 0), 0...4 ~= selectedHour{
                                            self.selectedHour = timeRange.first ?? selectedHour
                                        }
                                    }
                                    
                                    .presentationDragIndicator(.visible)
                                    .pickerStyle(WheelPickerStyle())
                                    .padding()
                                    
                                    Button("완료") {
                                        alarmTimeManager.selectedTime = Double(selectedHour)
                                        alarmTimeManager.progress = 0
                                        showPicker.toggle()
                                        
                                    }.font(.title2)
                                    
                                }.presentationDetents([.height(280)])
                                
                            }
                            
                            Button(action: {
                                self.showMainView = true
                            }) {
                                Text("시작하기")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor((1...8).contains(alarmTimeManager.selectedTime ?? 0) ? .alarmcolor2 : .gray)
                                    .frame(width: 308, height: 60)
                                    .background((1...8).contains(alarmTimeManager.selectedTime ?? 0) ? .white : .customGray)
                                    .cornerRadius(10)
                            }
                            .disabled(!(1...8).contains(alarmTimeManager.selectedTime ?? 0))
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
            MainView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature, location: $location)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
}

//#Preview {
//    AlarmView()
//}
