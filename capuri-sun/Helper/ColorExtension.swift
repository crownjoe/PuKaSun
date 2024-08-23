//
//  ColorExtension.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import SwiftUI

extension Color{
    
    static let backgroundBlue = Color(hex: "4095FF")
    static let customGray = Color(hex: "D9D9D9")
    static let customBlue = Color(hex: "2587FF")
    
    static let customBoxBlue = Color(hex: "2C89FB")
    
    static let customFontBlue = Color(hex: "167EFF")
    static let customLigntBlue = Color(hex: "59A2FF")
    static let customExplainBlue = Color(hex: "57A2FF")
    
    //SuncreamView
    static let suncreamYellow = Color(hex: "FBF9BC")
    static let suncreamFontYellow = Color(hex: "BDBB80")
        
    static let suncreamPink = Color(hex: "F9A2D7")
    static let suncreamFontPink = Color(hex: "F665BF")
    
    static let suncreamMint = Color(hex: "7FDBE0")
    static let suncreamFontMint = Color(hex: "44A4AA")
    
    static let suncreamOrange = Color(hex: "F8DFD4")
    static let suncreamFontOrange = Color(hex: "E7A691")
    
    static let suncreamBlue = Color(hex: "00CCD7")
    static let suncreamFontBlue = Color(hex: "00929A")
    
    static let suncreamBackBlue = Color(hex: "66A6F7")
    
    //UVView
    static let uv1 = Color(hex: "F8DFD4")
    static let uv2 = Color(hex: "FBF9BC")
    static let uv3 = Color(hex: "7FDBE0")
    static let uv4 = Color(hex: "FFDB55")
    static let uv5 = Color(hex: "FF7D7D")
    
    static let uvText = Color(hex: "DFEDFF")
    
    //MainView
    static let mainBlue = Color(hex: "318DFF")
    
    
    
    
    
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
