//
//  CommonLog.swift
//  SWUtils
//
//  Created by mhtran on 9/25/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

/**
 Interface of CMLog
 
 - parameter content:      Content to print log
 - parameter category:     Category of log
 - parameter functionName: Function name
 - parameter fileName:     Source file name
 - parameter lineNum:      Source file line number
 */
public func CMLog(_ content: String, category: String? = nil, functionName: String = #function,
                  fileName: String = #file, lineNum: Int = #line) {
    CMLogger.log(atSwiftFile: fileName, atMethod: functionName, atLine: lineNum, fromSource: nil,
                 withCategory: category, content: content)
}

public func CMLog(_ objects: Any?..., category: String? = nil, functionName: String = #function,
                  fileName: String = #file, lineNum: Int = #line, separator: String = "\n") {
    var content = ""
    for object in objects {
        if let str = object as? String {
            content += str + separator
        } else if let obj = object {
            content += "\(obj)" + separator
        } else {
            content += "<nil>" + separator
        }
    }
    if content.charsCount > 0 {
        let _ = content.remove(at: content.index(before: content.endIndex))
    }
    CMLogger.log(atSwiftFile: fileName, atMethod: functionName, atLine: lineNum, fromSource: nil,
                 withCategory: category, content: content)
}

/**
 Get object description by NSObject description or Swift \()
 
 - parameter object: Object
 
 - returns: String
 */
public func objectDescription(_ object: Any?) -> String? {
    if let obj = object as? NSObject {
        return obj.description
    } else if let obj = object {
        return "\(obj)"
    }
    return nil
}
