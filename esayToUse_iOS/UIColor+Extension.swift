//
//  UIColor+Extension.swift
//  ToGitHub
//
//  Created by Neil Wu on 2019/12/18.
//  Copyright © 2019 Neil Wu. All rights reserved.
//

import UIKit

extension UIColor {
    
    /**
     利用整數 GRBA 設定顏色，RGB為整數型態
     
     - Parameter redInt: R的色碼
     - Parameter greenInt: G的色碼
     - Parameter blueInt: B的色碼
     - Parameter alpha: 透明度，不設定為 1 (不透明)
     */
    convenience init(redInt: Int, greenInt: Int, blueInt: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(redInt) / 255.0,
            green: CGFloat(greenInt) / 255.0,
            blue: CGFloat(blueInt) / 255.0,
            alpha: alpha
        )
    }
    
    /**
     利用 16 進位 GRBA 設定顏色，RGB為 16 進位數字
     
     注意：16 進位數字前面會帶有 0x
     
     - Parameter HEX: 16 進位數字
     - Parameter alpha: 透明度，不設定為 1 (不透明)
     */
    convenience init(HEX: Int, alpha: CGFloat = 1.0) {
        self.init(
            redInt: (HEX >> 16) & 0xFF,
            greenInt: (HEX >> 8) & 0xFF,
            blueInt: HEX & 0xFF,
            alpha: alpha
        )
    }
    
    convenience init(HEX: String, alpha: CGFloat = 1.0) {
        
        var HEXStr = HEX
        
        if HEXStr.hasPrefix("0x") {
            let head = HEXStr.index(HEXStr.startIndex, offsetBy: 2)
            let tail = HEXStr.index(HEXStr.endIndex, offsetBy: 0)
            HEXStr = String(HEX[head ..< tail])
        }
        
        if HEXStr.hasPrefix("#") {
            let head = HEXStr.index(HEXStr.startIndex, offsetBy: 1)
            let tail = HEXStr.index(HEXStr.endIndex, offsetBy: 0)
            HEXStr = String(HEX[head ..< tail])
        }
        
        guard HEXStr.count == 6,
            let red = Int(HEXStr.dropLast(4), radix: 16),
            let green = Int(HEXStr.dropFirst(2).dropLast(2), radix: 16),
            let blue = Int(HEXStr.dropFirst(4), radix: 16)
            else {
                self.init(redInt: 0, greenInt: 0, blueInt: 0, alpha: 0)
                return
        }
        self.init(redInt: red, greenInt: green, blueInt: blue, alpha: alpha)
    }
    
}
