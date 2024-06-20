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
    @State private var selectedHour: Int? = nil
    
    @AppStorage("alarmTime") var alarmTime: Double = 0.0
    
    @State private var selectedButton: Int? = nil
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
                    .padding(.bottom, 40)
                    
                    VStack(spacing: 22) {
                        ZStack {
                            Color.alarmcolor
                                .frame(width: 308, height: 60)
                                .cornerRadius(20)
                            
                            HStack {
                                Button(action: {
                                    selectedHour = 2
                                    connectData()
                                    selectedHour = 0
                                }) {
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
                        
                        Button(action: {
                            selectedHour = 3
                            connectData()
                            selectedHour = 0
                        }) {
                            Text("3시간마다")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 308, height: 60)
                                .background(Color.alarmcolor)
                                .cornerRadius(20)
                        }
                        
                        
                        VStack {
                            Button(action: {
                                showPicker.toggle()
                            }) {
                                Text("\(selectedHour != nil && selectedHour != 0 ? "\(selectedHour!)" : "_")시간마다")
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .frame(width: 308, height: 60)
                                    .background(Color.alarmcolor)
                                    .cornerRadius(20)
                                    .padding(.bottom, 22)
                            }
                            
                            .sheet(isPresented: $showPicker) {
                                VStack {
                                    Picker("시간", selection: $selectedHour) {
                                        ForEach(4..<9, id: \.self) { hour in
                                            Text("\(hour)").tag(hour as Int?)
                                        }
                                    }
                                    .presentationDragIndicator(.visible)
                                    .pickerStyle(WheelPickerStyle())
                                    .padding()
                                    
                                    Button("완료") {
                                        showPicker.toggle()
                                        connectData()
                                    }
                                    
                                }.presentationDetents([.height(250)])
                                
                            }
                            
                            Button(action: {
                                selectedHour = 0
                                connectData()
                            }) {
                                Text("안받을게요🥲")
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .frame(width: 308, height: 60)
                                    .background(Color.alarmcolor)
                                    .cornerRadius(20)
                                    .padding(.bottom, 95)
                            }
                            
                            HStack {
                                Button(action: {
                                    self.showMainView = true
                                }) {
                                    Text("시작하기")
                                        .bold()
                                        .font(.system(size: 20))
                                        .foregroundColor(.alarmcolor2)
                                        .frame(width: 308, height: 60)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        else {
            MainView(address: $address, uvIndex: $uvIndex, condition: $condition, temperature: $temperature, alarmTime: $alarmTime)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
    
    func connectData() {
        let hour = selectedHour ?? 0
        alarmTime = Double(hour * 60)
        print(alarmTime)
    }
}

//#Preview {
//    AlarmView()
//}
