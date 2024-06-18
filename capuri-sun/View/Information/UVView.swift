//
//  UVView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI

struct UVView: View {
    
    @State private var showFirstHStack1 = true
    @State private var showFirstHStack2 = true
    @State private var showFirstHStack3 = true
    @State private var showFirstHStack4 = true
    @State private var showFirstHStack5 = true
    
    // TODO: 애니메이션 이슈 해결
    
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
                        
                        if showFirstHStack1 {
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
                            .transition(.flipFromLeft)
                        }
                        else {
                            HStack{
                                
                                VStack(alignment: .trailing, spacing: 8){
                                    Text("햇빛 노출 보호조치가 필요하지 않음")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    Text("그러나 햇볕에 민감한 피부를 가진")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    Text("분은 자외선 차단제를 발라야 함")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                }
                                
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.uv1)
                            }
                            .transition(.flipFromRight)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            showFirstHStack1.toggle()
                        }
                    }
                    
                    ZStack {
                        Image("img_low2")
                        if showFirstHStack2 {
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
                            }.transition(.flipFromLeft)
                        }
                        
                        else{
                            HStack{
                                VStack(alignment: .trailing, spacing: 8){
                                    
                                    Text("2~3시간 내에도 햇볕에 노출 시에")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                    Text("피부 화상을 입을 수 있음")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                }
                                
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.uv2)
                            }.transition(.flipFromRight)
                        }
                    } .onTapGesture {
                        withAnimation {
                            showFirstHStack2.toggle()
                        }
                    }
                    
                    ZStack {
                        Image("img_low3")
                        
                        if showFirstHStack3 {
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
                            }.transition(.flipFromLeft)
                        }
                        
                        else{
                            HStack{
                                VStack(alignment: .trailing, spacing: 8){
                                    
                                    Text("1~2시간 내에도 햇볕에 노출 시에")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                    Text("피부 화상을 입을 수 있음. 이 단계부터")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                    Text("긴 소매 옷, 모자, 선글라스 이용")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                }
                                
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.uv3)
                            }.transition(.flipFromRight)
                        }
                        
                    }
                    .onTapGesture {
                        withAnimation{
                            showFirstHStack3.toggle()
                        }
                    }
                    
                    ZStack {
                        Image("img_low4")
                        
                        if showFirstHStack4 {
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
                            }.transition(.flipFromLeft)
                        }
                        
                        else{
                            
                            HStack{
                                
                                VStack(alignment: .trailing, spacing: 6){
                                    
                                    Text("수십 분 이내에도 햇볕에 노출 시에")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                    Text("피부 화상을 입을 수 있어 매우 위험함")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                    Text("오전 10시부터 오후 3시까지 외출을")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                    Text("피하고 실내나 그늘에 머물러야 함")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                }
                                
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.uv4)
                            }.transition(.flipFromRight)
                        }
                        
                        
                    }
                    .onTapGesture {
                        withAnimation{
                            showFirstHStack4.toggle()
                        }
                    }
                    
                    ZStack {
                        Image("img_low5")
                        
                        if showFirstHStack5 {
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
                            }.transition(.flipFromLeft)
                        }
                        
                        else {
                            HStack{
                                
                                VStack(alignment: .trailing, spacing: 8){
                                    
                                    Text("수십 분 이내에도 햇볕에 노출 시에")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                    Text("피부 화상을 입을 수 있어 가장 위험함")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                    Text("가능한 실내에 머물러야 함")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    
                                    
                                }
                                
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.uv5)
                            }.transition(.flipFromRight)
                        }
                        
                    }
                    .onTapGesture {
                        withAnimation{
                            showFirstHStack5.toggle()
                        }
                    }
                    
                }
                
            }
            
        }.ignoresSafeArea(.all)
    }
}

extension AnyTransition {
    static var flipFromLeft: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: .modifier(
                active: FlipModifier(angle: 90, axis: (x: 0, y: 1)),
                identity: FlipModifier(angle: 0, axis: (x: 0, y: 1))
            )
        )
    }
    
    static var flipFromRight: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: .modifier(
                active: FlipModifier(angle: -90, axis: (x: 0, y: 1)),
                identity: FlipModifier(angle: 0, axis: (x: 0, y: 1))
            )
        )
    }
}

struct FlipModifier: ViewModifier {
    let angle: Double
    let axis: (x: CGFloat, y: CGFloat)
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(angle),
                axis: (x: axis.x, y: axis.y, z: 0),
                perspective: 0.5
            )
    }
}

#Preview {
    UVView()
}
