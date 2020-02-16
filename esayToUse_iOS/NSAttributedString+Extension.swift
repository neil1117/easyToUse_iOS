//
//  NSAttributedString+Extension.swift
//  ToGitHub
//
//  Created by Neil Wu on 2019/12/18.
//  Copyright © 2019 Neil Wu. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    /**
     將文字某段設成連結
     
     若設定的字串在文章內重複多次，只會取第一個
     
     - Parameter text: 整段文字
     - Parameter targetAndScheme: key 為要變成連結的文字段，value 為要對應的連結 scheme
     
     - Returns: 設定好的 NSAttributedString
     */
    public class func getlinkString(withText text: String, targetAndScheme: [String: String]) -> NSAttributedString
    {
        let attStr = NSMutableAttributedString.init(string: text)
        for target in targetAndScheme.keys {
            if let range = text.range(of: target), let scheme = targetAndScheme[target] {
                let linkScheme = "\(scheme)://"
                attStr.addAttribute(.link, value: linkScheme, range: text.nsRange(from: range))
            }
        }
        return attStr;
    }
}
