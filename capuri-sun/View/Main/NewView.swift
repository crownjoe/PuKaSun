//
//  NewView.swift
//  capuri-sun
//
//  Created by 조세연 on 7/23/24.
//

import SwiftUI
import CoreLocation

struct NewView: View {
    
    @State private var pathModel: PathModel = .init()
    
    //    @Binding var address: String
    //    @Binding var uvIndex: String
    //    @Binding var condition: String
    //    @Binding var temperature: String
    //    @Binding var location: CLLocation?
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            ZStack{
                Image(.imgBackground)
                    .resizable()
                    .ignoresSafeArea(.all)
                
                VStack{
                    
                    HStack(spacing : 4){
                        Image(.imgLocation)
                        
                        Text("포항시, 지곡동")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        
                        Text("맑음")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        
                        Text("21.0°")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        
                        //                    Text(address)
                        //                        .font(.system(size: 15))
                        //                        .foregroundColor(.white)
                        //
                        //                    Text(condition)
                        //                        .font(.system(size: 15))
                        //                        .foregroundColor(.white)
                        //
                        //                    Text(temperature)
                        //                        .font(.system(size: 15))
                        //                        .foregroundColor(.white)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.customBlue)
                    .cornerRadius(20)
                    
                    UVindexView()
                    
                    pukaiconView()
                }
            }
        }
        
        
    }
}

struct UVindexView : View {
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 256)
                .foregroundColor(.customBlue)
            
            VStack {
                Text("UV 지수")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.customLigntBlue)
                    .frame(width: 77, height: 33)
                    .background(Color.red)
                    .padding(.bottom, 15)
                
                
                Text("1") // UVindex
                    .font(.system(size: 160))
                    .fontWeight(.bold)
                    .foregroundColor(.suncreamPink)
                    .background(Color.green)
                    .frame(width: 77, height: 160)
                    .padding(.bottom, 18)
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.suncreamPink)
                        .frame(width: 94, height: 38)
                        .cornerRadius(18)
                    
                    
                    Text("낮음") // UVindex
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.customFontBlue)
                }
            }
        }
    }
}

struct pukaiconView: View {
    var body: some View {
        HStack(spacing: 60) {
            
            Image(.iconPuka1)
                .resizable()
                .frame(width: 220, height: 348)
            
            buttonView()
            
        }
    }
}

struct buttonView: View {
    var body: some View {
        VStack(spacing: 35) {
            Spacer()
                .frame(height: 70)
            Image(.iconUv)
            Image(.iconAlarm)
            Image(.iconSuncream)
        }
    }
}

struct mainButtonView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 340, height: 92)
                .foregroundColor(.customBoxBlue)
                .cornerRadius(16)
            
//            outButtonView()
//            progressView()
            endButtonView()
        }
    }
}

struct outButtonView: View {
    var body: some View {
        Image(.imgOutbtn)
    }
}


struct progressView: View {
    var body: some View {
        HStack {
            Image(.iconSuncreambtn)
                .padding(.trailing, 16)
                .padding(.leading, 30)
            
            VStack(alignment: .leading) {
                Text("2시간 30분")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.suncreamPink)
                
                Text("후에 자외선 차단제를 발라주세요!")
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
        }
    }
}

struct endButtonView: View {
    var body: some View {
        HStack {
            Image(.imgEndbtn)
                .padding(.trailing, 18)
                .padding(.leading, 24)
            
            VStack(alignment: .leading) {
                Text("자외선 차단제를")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.suncreamPink)
                
                Text("바르실 시간입니다!")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
        }
    }
}





#Preview {
//    NewView()
//    outButtonView()
    mainButtonView()
}
