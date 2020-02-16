//
//  LocalizationHelper.swift
//  esayToUse_iOS
//
//  Created by Neil Wu on 2020/2/16.
//  Copyright © 2020 Neil Wu. All rights reserved.
//

import Foundation

/**
 簡化呼叫 NSLocalizedString
 
 - Parameter key: 多國語系對應的Key
 
 - Returns: 對應的語言字串
 */
public func LocalString(key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

/**
 簡化呼叫 NSLocalizedString
 
 - Parameter key: 多國語系對應的Key
 
 - Parameter parameter: 可動的參數，對應到字串的%@
 
 - Returns: 對應的語言字串
 */
public func LocalString(key: String, parameter: [String]) -> String {
    return String(format: LocalString(key: key), arguments: parameter)
}
