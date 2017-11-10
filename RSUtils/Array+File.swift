//
//  Array+File.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation
extension Array: ReadableWritable, WritableConvertible {
    
    /// Returns an array from the given path.
    ///
    /// - Parameter path: The path to be returned the array for.
    /// - Throws: FileKitError.ReadFromFileFail
    ///
    public static func read(from path: Path) throws -> Array {
        guard let contents = NSArray(contentsOfFile: path._safeRawValue) else {
            throw FileKitError.readFromFileFail(path: path, error: FileKitError.ReasonError.conversion(NSArray.self))
        }
        guard let dict = contents as? Array else {
            throw FileKitError.readFromFileFail(path: path, error: FileKitError.ReasonError.conversion(Array.self))
        }
        return dict
    }
    
    // Return an bridged NSArray value
    public var writable: NSArray {
        return self as NSArray
    }
    
}
