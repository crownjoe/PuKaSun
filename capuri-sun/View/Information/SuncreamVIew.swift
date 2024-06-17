//
//  SuncreamVIew.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI

struct SuncreamVIew: View {
    var body: some View {
        ZStack{
            Color.backgroundBlue
            
            VStack{
                HStack(spacing: 294){
                    Image("img_before")
                    
                    Text("닫기")
                        .font(.system(size: 20))
                        .foregroundColor(.customGray)
                }
                Spacer()
                    .frame(height: 17)
                
                HStack{
                    VStack(alignment: .leading, spacing: 6){
                        Text("어떤 자외선 차단제를\n발라야 할까요?")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                        
                        Text("카드를 뒤집어 주세요!")
                            .font(.system(size: 15))
                            .foregroundColor(.customGray)
                            .padding(.all, 7)
                            .background(Color.suncreamBackBlue)
                            .cornerRadius(20)
                    }
                    Spacer()
                        .frame(width: 109)
                }
                
                Spacer()
                    .frame(height: 20)
                
                VStack(spacing: 11){
                    HStack(spacing: 7){
                        VStack(spacing: 11){
                            
                            ZStack{
                                Image("img_suncream1")
                                    .resizable()
                                    .frame(width: 190, height: 190)
                                
                                Text("실내")
                                    .fontWeight(.bold)
                                    .font(.system(size: 35))
                                    .foregroundColor(.suncreamFontYellow)
                            }
                            
                            ZStack{
                                Image("img_suncream3")
                                    .resizable()
                                    .frame(width: 190, height: 249)
                                Text("스포츠\n  야외 \n  활동")
                                    .fontWeight(.bold)
                                    .font(.system(size: 35))
                                    .foregroundColor(.suncreamFontMint)
                            }
                            
                        }
                        
                        VStack(spacing: 11){
                            
                            ZStack{
                                Image("img_suncream2")
                                    .resizable()
                                    .frame(width: 160, height: 278)
                                Text("간\n단\n한\n외\n출")
                                    .fontWeight(.bold)
                                    .font(.system(size: 35))
                                    .foregroundColor(.suncreamFontPink)
                                
                            }
                            ZStack{
                                Image("img_suncream4")
                                    .resizable()
                                    .frame(width: 160, height: 160)
                                Text("  등산\n해수욕")
                                    .fontWeight(.bold)
                                    .font(.system(size: 35))
                                    .foregroundColor(.suncreamFontOrange)
                            }
                        }
                    }
                    ZStack{
                        Image("img_suncream5")
                            .resizable()
                            .frame(width: 357, height: 118)
                        Text("야외 물놀이            ")
                            .fontWeight(.bold)
                            .font(.system(size: 35))
                            .foregroundColor(.suncreamFontBlue)
                    }
                    
                }
            }
            
        }.ignoresSafeArea(.all)
    }
}

#Preview {
    SuncreamVIew()
}
