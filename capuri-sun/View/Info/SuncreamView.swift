//
//  SuncreamView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI

struct SuncreamView: View {
    
    @State private var imageName1 = "img_suncream1"
    @State private var text1 = "실내"
    
    @State private var imageName2 = "img_suncream2"
    @State private var text2 = "간\n단\n한\n외\n출"
    
    @State private var imageName3 = "img_suncream3"
    @State private var text3 = "스포츠\n  야외 \n  활동"
    
    @State private var imageName4 = "img_suncream4"
    @State private var text4 = "  등산\n해수욕"
    
    @State private var imageName5 = "img_suncream5"
    @State private var text5 = "야외 물놀이            "
    
    @Binding var address: String
    @Binding var uvIndex: String
    @Binding var condition: String
    @Binding var temperature: String
    

    var body: some View {
        ZStack{
            Color.backgroundBlue
                .ignoresSafeArea(.all)
            
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 6){
                        Text("어떤 자외선 차단제를\n발라야 할까요?")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding(.top, 40)
                        
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
                                Image(imageName1)
                                    .resizable()
                                    .frame(width: 190, height: 190)
                                
                                Text(text1)
                                    .fontWeight(.bold)
                                    .font(.system(size: 35))
                                    .foregroundColor(.suncreamFontYellow)
                            }.onTapGesture {
                                
                                // TODO: 애니메이션
                                
                                if imageName1 == "img_suncream1" {
                                    imageName1 = "img_aftersuncream1"
                                    text1 = ""
                                } else {
                                    imageName1 = "img_suncream1"
                                    text1 = "실내"
                                }
                            }
                            
                            ZStack{
                                Image(imageName3)
                                    .resizable()
                                    .frame(width: 190, height: 249)
                                Text(text3)
                                    .fontWeight(.bold)
                                    .font(.system(size: 35))
                                    .foregroundColor(.suncreamFontMint)
                            }.onTapGesture {
                                if imageName3 == "img_suncream3" {
                                    imageName3 = "img_aftersuncream3"
                                    text3 = ""
                                } else {
                                    imageName3 = "img_suncream3"
                                    text3 = "스포츠\n  야외 \n  활동"
                                }
                            }
                            
                        }
                        
                        VStack(spacing: 11){
                            
                            ZStack{
                                Image(imageName2)
                                    .resizable()
                                    .frame(width: 160, height: 278)
                                Text(text2)
                                    .fontWeight(.bold)
                                    .font(.system(size: 35))
                                    .foregroundColor(.suncreamFontPink)
                                
                            }.onTapGesture {
                                if imageName2 == "img_suncream2" {
                                    imageName2 = "img_aftersuncream2"
                                    text2 = ""
                                } else {
                                    imageName2 = "img_suncream2"
                                    text2 = "간\n단\n한\n외\n출"
                                }
                            }
                            
                            
                            ZStack{
                                Image(imageName4)
                                    .resizable()
                                    .frame(width: 160, height: 160)
                                Text(text4)
                                    .fontWeight(.bold)
                                    .font(.system(size: 35))
                                    .foregroundColor(.suncreamFontOrange)
                            } .onTapGesture {
                                if imageName4 == "img_suncream4" {
                                    imageName4 = "img_aftersuncream4"
                                    text4 = ""
                                } else {
                                    imageName4 = "img_suncream4"
                                    text4 = "  등산\n해수욕"
                                }
                            }
                            
                        }
                    }
                    ZStack{
                        Image(imageName5)
                            .resizable()
                            .frame(width: 357, height: 118)
                        Text(text5)
                            .fontWeight(.bold)
                            .font(.system(size: 35))
                            .foregroundColor(.suncreamFontBlue)
                    }
                    .onTapGesture {
                                if imageName5 == "img_suncream5" {
                                    imageName5 = "img_aftersuncream5"
                                    text5 = ""
                                } else {
                                    imageName5 = "img_suncream5"
                                    text5 = "야외 물놀이            "
                                }
                            }
                    
                }
            }
            
        }
        .ignoresSafeArea(.all)
    }
}

//#Preview {
//    SuncreamView()
//}
