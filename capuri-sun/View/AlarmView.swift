import SwiftUI

struct ContentView: View {
    @State private var showPicker = false
    @State private var selectedHour: Int? = nil
    @State private var selectedButton: Int? = nil
    var body: some View {
        
        
        ZStack {
            Image("img_AlarmBackground")
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
                Spacer().frame(height: 5)
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
                
                
                VStack(spacing: 22) {Button(action: {
                    print("Button tapped!")
                }) {
                    
                    ZStack {
                        Color.alarmcolor
                            .frame(width: 307.96, height: 59)
                            .cornerRadius(20)
                        
                        
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
                    
                    Button(action: {
                        print("Button tapped!")
                    }) {
                        Text("3시간마다")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 307.96, height: 59)
                            .background(Color.alarmcolor)
                            .cornerRadius(20)
                    }
                    
                    
                    VStack {
                        Button(action: {
                            showPicker.toggle()
                        }) {
                            Text("\(selectedHour != nil ? "\(selectedHour!)" : "__")시간마다")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 307.96, height: 59)
                                .background(Color.alarmcolor)
                                .cornerRadius(20)
                                .padding(.bottom, 22)
                        }
                        
                        
                        // Picker가 나타나는 Sheet
                        .sheet(isPresented: $showPicker) {
                            VStack {
                                Picker("시간", selection: $selectedHour) {
                                    ForEach(1..<25, id: \.self) { hour in
                                        Text("\(hour)").tag(hour as Int?)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .padding()
                                
                                Button("완료") {
                                    showPicker.toggle()
                                }
                                
                            }
                            
                        }
                        
                        
                        Button(action: {
                            print("Button tapped!")
                        }) {
                            Text("안받을게요🥲")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 307.96, height: 59)
                                .background(Color.alarmcolor)
                                .cornerRadius(20)
                                .padding(.bottom, 95)
                        }
                        
                        
                        
                        
                        HStack {
                            Button(action: {
                                print("Button tapped!")
                            }) {
                                Text("시작하기")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.alarmcolor2)
                                    .frame(width: 307.96, height: 59)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                
                            }
                            
                           
                            .padding()
                            
                        }
                    }
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
