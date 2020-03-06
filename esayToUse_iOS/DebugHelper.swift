//
//  DebugHelper.swift
//  ToGitHub
//
//  Created by Neil Wu on 2019/12/17.
//  Copyright © 2019 Neil Wu. All rights reserved.
//

import UIKit

let Debuger = DebugHelper()

let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String

#if DEBUG
let logPath = NSHomeDirectory() + "/Documents/\(appName ?? "")_DebugLog_Dev.txt"
#endif
#if STAGE
let logPath = NSHomeDirectory() + "/Documents/\(appName ?? "")_DebugLog_Stage.txt"
#endif

class DebugHelper {
    
    func createDebugLog() {
        
        #if DEBUG || STAGE
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSSSSS"
        var dateString = ""
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: logPath) {
            dateString = "\n=======================================================\n" + formatter.string(from: date) + "\n"
            
        } else {
            fileManager.createFile(atPath: logPath, contents: nil, attributes: nil)
            dateString = formatter.string(from: date) + "\n"
        }
        let data = dateString.data(using: String.Encoding.utf8, allowLossyConversion: false)!

        if fileManager.fileExists(atPath: logPath) {
            if let fileHandle = FileHandle(forWritingAtPath: logPath) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        }
        #endif
    }
}

extension String {
    
    func writeToDebugLog(file: String = #file, function: String = #function, line: Int = #line) {
        #if DEBUG || STAGE
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: logPath) {
            fileManager.createFile(atPath: logPath, contents: nil, attributes: nil)
        }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSSSSS"
        let dateStr = formatter.string(from: date)
        let allString = dateStr + " " + self + "\n"
        
        let data = allString.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        if fileManager.fileExists(atPath: logPath) {
            if let fileHandle = FileHandle(forWritingAtPath: logPath) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        }
        #endif
    }
}

/**
 列印 debug 資訊

 只會在 DEBUG、STAGE 環境執行

 - Parameter object: 要印出的資訊
 - Parameter functionName: 所在的 function 名稱
 - Parameter fileName: 所在的檔案名稱
 - Parameter lineNumber: 所在的行數
 */
public func debugLog(_ object: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    #if DEBUG || STAGE
    let className = (fileName as NSString).lastPathComponent
    let logStr = "<\(className)> \(functionName) [#\(lineNumber)]|\n\(object)\n"
    print(logStr)
    logStr.writeToDebugLog()
    #endif
}

/**
 列印是不是在主要執行續

 只會在 DEBUG、STAGE 環境執行

 - Parameter functionName: 所在的 function 名稱
 - Parameter fileName: 所在的檔案名稱
 - Parameter lineNumber: 所在的行數
 */
public func debugThread(functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    #if DEBUG || STAGE
    let className = (fileName as NSString).lastPathComponent
    print("<\(className)> \(functionName) [#\(lineNumber)]| isMainThread: \(Thread.isMainThread)\n")
    #endif
}

