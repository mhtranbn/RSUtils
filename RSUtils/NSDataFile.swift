//
//  NSDataFile.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

/// A representation of a filesystem data file.
///
/// The data type is NSData.
public typealias NSDataFile = File<NSData>

extension File where DataType: NSData {

    /// Reads the file and returns its data.
    /// - Parameter options: A mask that specifies write options
    ///                      described in `NSData.ReadingOptions`.
    ///
    /// - Throws: `FileKitError.ReadFromFileFail`
    /// - Returns: The data read from file.
    public func read(_ options: NSData.ReadingOptions) throws -> NSData {
        return try NSData.read(from: path, options: options)
    }

    /// Writes data to the file.
    ///
    /// - Parameter data: The data to be written to the file.
    /// - Parameter options: A mask that specifies write options
    ///                      described in `NSData.WritingOptions`.
    ///
    /// - Throws: `FileKitError.WriteToFileFail`
    ///
    public func write(_ data: NSData, options: NSData.WritingOptions) throws {
        do {
            try data.write(toFile: self.path._safeRawValue, options: options)
        } catch {
            throw FileKitError.writeToFileFail(path: self.path, error: error)
        }
    }

}
