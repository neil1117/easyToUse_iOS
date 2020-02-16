//
//  Stirng+Extension.swift
//  ToGitHub
//
//  Created by Neil Wu on 2019/11/17.
//  Copyright © 2019 Neil Wu. All rights reserved.
//

import UIKit

extension String {
    /**
     檢查字串是否超過設定的字數
     
     - Parameter min: 至少要多少個字數
     
     - Returns: 是否有超過設定的字數
     */
    func checkStringCount(least min: Int) -> Bool {
        let pattern = ".{\(min),}"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue:0))
        let res = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, self.count))
        if res.count > 0 {
        return true
        } else {
            return false
        }
    }
    
    /**
     檢查字串是否含有大小寫
     
     有大、小寫為 true
     
     - Returns: true 為含有大寫及小寫
     */
    func includeUppercaseAndLowercased() -> Bool {
        let pattern = "(?=.*?[A-Z])(?=.*?[a-z]).+"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue:0))
        let res = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, self.count))
        if res.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    /**
     檢查字串是否含有數字
     
     - Returns: true 為含有數字
     */
    func includeDigital() -> Bool {
        let pattern = "(?=.*?[0-9]).+"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue:0))
        let res = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, self.count))
        if res.count > 0 {
            return true
        } else {
            return false
        }
        
    }
    
    /**
     檢查字串是否為手機的格式
     
     - Important: 台灣的手機格式
     
     - Returns: true 為手機的格式
     */
    func isPhoneNumber() -> Bool  {
        let pattern = "((\\+886|0)+([0-9]){9})$"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue:0))
        let res = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, self.count))
        if res.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    /**
     檢查字串是否含有除了大小寫英文字母及數字以外的字元
     
     - Returns: true 為含有除了大小寫英文字母及數字以外的字元
     */
    func checkHasSymbol() -> Bool {
        let pattern = ".*[^A-Za-z0-9].*"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue:0))
        let res = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, self.count))
        if res.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    /**
     將文字內某段文字的 Range 轉成 NSRange
     */
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    func ranges(of searchString: String, options mask: NSString.CompareOptions = [], locale: Locale? = nil) -> [Range<String.Index>] {
        var ranges: [Range<String.Index>] = []
        while let range = range(of: searchString, options: mask, range: (ranges.last?.upperBound ?? startIndex)..<endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
    }
    
    func nsRanges(of searchString: String, options mask: NSString.CompareOptions = [], locale: Locale? = nil) -> [NSRange] {
        let ranges = self.ranges(of: searchString, options: mask, locale: locale)
        return ranges.map { nsRange(from: $0) }
    }
    
    /**
     將 JSON 轉成 JSON 字串
     
     - Parameter any: JSON
     
     - Returns: JSON 字串
     */
    public static func getJsonString(withAny any: Any) -> String {
        var result = ""
        do {
            let data =  try JSONSerialization.data(withJSONObject: any, options: JSONSerialization.WritingOptions.prettyPrinted)
            if let str = String(data: data, encoding: String.Encoding.utf8) {
                result = str
            }
        } catch let myJSONError {
            print(myJSONError)
        }
        return result
    }
    
    /**
     將 JSON字串 轉成 JSON
     
     - Returns: JSON
     */
    func jsonStingToAnyType() -> Any? {
        let data = self.data(using: .utf8)!
        var result: Any? = nil
        do {
            result = try JSONSerialization.jsonObject(with: data, options : .allowFragments)
            print(result as Any)
        } catch let error as NSError {
            print(error)
        }
        return result
    }
    
    /**
     取得字串的寬
     
     根據字型及限制的高計算字串的寬度
     
     - Parameter font: 要用的字型
     - Parameter height: 限制的高度
     
     - Returns: 寬度
     */
    public func getTextWidth(font:UIFont, height:CGFloat) -> CGFloat {
        
        let size = CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        
        let stringSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]), context:nil).size
        
        return stringSize.width
        
    }
    
    /**
     取得字串的高
     
     根據字型及限制的寬計算字串的寬度
     
     - Parameter font: 要用的字型
     - Parameter height: 限制的寬度
     
     - Returns: 高度
     */
    public func getTextHeight(font:UIFont, width:CGFloat) -> CGFloat {
        
        let size = CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        
        let stringSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]), context:nil).size
        
        return stringSize.height
        
    }
}
