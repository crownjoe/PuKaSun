import SwiftUI
import CoreLocation

struct AlarmView: View {
    
    @State private var showPicker = false
    @State private var showMainView = false
    @State private var selectedHour: Int = 0
    @State private var isClicked: Bool = false
    @State private var selectedButton: Int? = nil
    
    @Binding var changeMainView: Bool
    
    @ObservedObject private var alarmTimeManager = AlarmTimeManager()
    
    @Environment(PathModel.self) var pathModel
    
    let timeRange = 5..<9
    
    var body: some View {
        if !showMainView{
            ZStack {
                Image(.imgBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("자외선 차단제")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                        .padding(.bottom, 8)
                        .padding(.top, 100)
                    
                    HStack(spacing: 0) {
                        Text("알림주기")
                            .bold()
                            .font(.system(size: 28))
                            .foregroundColor(.alarmcolor3)
                            .fontWeight(.bold)
                        
                        Text("를 설정해 주세요")
                            .bold()
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                    
                    Text("설정한 시간으로 정기적 알림을 드려요.")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                        .padding(.leading, 20)
                        .padding(.bottom, 56)
                    
                    // MARK: - 2시간마다
                    VStack(spacing: 32) {
                        ZStack {
                            Color.alarmcolor
                                .frame(width: 302, height: 60)
                                .cornerRadius(24)
                            
                            HStack {
                                Button {
                                    alarmTimeManager.selectedTime = 1
                                    // 원래 2임!!
                                    alarmTimeManager.progress = 0
                                } label: {
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
                            //여기도 2임
                            alarmTimeManager.selectedTime == 1 ?
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.suncreamPink, lineWidth: 4)
                            : nil
                        )
                        
                        // MARK: - 3시간마다
                        Button {
                            alarmTimeManager.selectedTime = 3
                            alarmTimeManager.progress = 0
                        } label : {
                            Text("3시간마다")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 302, height: 60)
                                .background(Color.alarmcolor)
                                .cornerRadius(24)
                        }
                        .overlay(
                            alarmTimeManager.selectedTime == 3 ?
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.suncreamPink, lineWidth: 4)
                            : nil
                        )
                        
                        // MARK: - 4시간마다
                        Button {
                            alarmTimeManager.selectedTime = 4
                            alarmTimeManager.progress = 0
                        } label : {
                            Text("4시간마다")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 302, height: 60)
                                .background(Color.alarmcolor)
                                .cornerRadius(24)
                        }
                        .overlay(
                            alarmTimeManager.selectedTime == 4 ?
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.suncreamPink, lineWidth: 4)
                            : nil
                        )
                        
                        VStack {
                            // MARK: - _시간마다
                            Button {
                                showPicker.toggle()
                            } label : {
                                Text("\(0...4 ~= (alarmTimeManager.selectedTime ?? 0) ? "__시간마다" : "\(Int(alarmTimeManager.selectedTime ?? 0))시간마다")")
                                
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .frame(width: 302, height: 60)
                                    .background(Color.alarmcolor)
                                    .cornerRadius(24)
                            }
                            .overlay(
                                (alarmTimeManager.selectedTime == 5 || alarmTimeManager.selectedTime == 6 || alarmTimeManager.selectedTime == 7 || alarmTimeManager.selectedTime == 8) ?
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.suncreamPink, lineWidth: 4)
                                : nil
                            )
//                            .padding(.bottom, 80)
                            
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
                            
                            Spacer()
                            
                            Button {
                                self.showMainView = true
                                changeMainView = true
                                
                            } label : {
                                Text("다음")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor((1...8).contains(alarmTimeManager.selectedTime ?? 0) ? .alarmcolor2 : .gray)
                                    .frame(width: 329, height: 60)
                                    .background((1...8).contains(alarmTimeManager.selectedTime ?? 0) ? .white : .customGray)
                                    .cornerRadius(10)
                            }
//                            .disabled(!(1...8).contains(alarmTimeManager.selectedTime ?? 0))
                            .padding(.bottom, 80)
                        }
                    }
                }
            }

        }
    }
}

//#Preview {
//    AlarmView()
//}
