//
//  Dictionary+File.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation
extension Dictionary: ReadableWritable, WritableConvertible {
    
    /// Returns a dictionary from the given path.
    ///
    /// - Parameter path: The path to be returned the dictionary for.
    /// - Throws: FileKitError.ReadFromFileFail
    ///
    public static func read(from path: Path) throws -> Dictionary {
        guard let contents = NSDictionary(contentsOfFile: path._safeRawValue) else {
            throw FileKitError.readFromFileFail(path: path, error: FileKitError.ReasonError.conversion(NSDictionary.self))
        }
        guard let dict = contents as? Dictionary else {
            throw FileKitError.readFromFileFail(path: path, error: FileKitError.ReasonError.conversion(Dictionary.self))
        }
        return dict
    }
    
    // Return an bridged NSDictionary value
    public var writable: NSDictionary {
        return self as NSDictionary
    }
    
}
