//
//  UVView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI

struct UVView: View {
    
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
                
                VStack(alignment: .center, spacing: 14){
                    Text("자외선 지수 단계는?")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    
                    Text("카드를 뒤집어 주세요!")
                        .font(.system(size: 15))
                        .foregroundColor(.customGray)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 83)
                        .background(Color.suncreamBackBlue)
                        .cornerRadius(20)
                }
                Spacer()
                    .frame(height: 33)
                
                VStack(alignment: .center, spacing: 4){
                    
                    
                    ZStack {
                        Image("img_low1")
                        
                        HStack{
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.uv1)
                                .padding(.trailing, 16)
                            
                            Text("낮음")
                                .fontWeight(.bold)
                                .font(.system(size: 35))
                                .foregroundColor(.uv1)
                                .padding(.trailing, 20)
                            
                            
                            Text("1 - 2")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .foregroundColor(.uvText)
                        }
                    }
                    
                    ZStack {
                        Image("img_low2")
                        
                        HStack{
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.uv2)
                                .padding(.trailing, 16)
                            
                            Text("보통")
                                .fontWeight(.bold)
                                .font(.system(size: 35))
                                .foregroundColor(.uv2)
                                .padding(.trailing, 20)
                            
                            Text("3 - 5")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .foregroundColor(.uvText)
                        }
                    }
                    
                    ZStack {
                        Image("img_low3")
                        
                        HStack{
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.uv3)
                                .padding(.trailing, 16)
                            
                            Text("높음")
                                .fontWeight(.bold)
                                .font(.system(size: 35))
                                .foregroundColor(.uv3)
                                .padding(.trailing, 20)
                            
                            Text("6 - 7")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .foregroundColor(.uvText)
                        }
                    }
                    
                    ZStack {
                        Image("img_low4")
                        
                        HStack{
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.uv4)
                                .padding(.trailing, 16)
                            
                            Text("매우\n높음")
                                .fontWeight(.bold)
                                .font(.system(size: 35))
                                .foregroundColor(.uv4)
                                .padding(.trailing, 20)
                            
                            Text("8 - 10")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .foregroundColor(.uvText)
                        }
                    }
                    
                    ZStack {
                        Image("img_low5")
                        
                        HStack{
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.uv5)
                                .padding(.trailing, 16)
                            
                            Text("위험")
                                .fontWeight(.bold)
                                .font(.system(size: 35))
                                .foregroundColor(.uv5)
                                .padding(.trailing, 20)
                            
                            Text("11 이상")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .foregroundColor(.uvText)
                        }
                    }
                    
                    
                    
                }
                    
                }
                
  
        }.ignoresSafeArea(.all)
    }
}

#Preview {
    UVView()
}
