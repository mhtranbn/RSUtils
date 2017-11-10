//
//  NSString+FileKit.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

extension NSString {

    /// Returns an String object initialized by copying the characters from
    /// the raw value of a given path.
    public convenience init(path: Path) {
        self.init(string: path.rawValue)
    }

}

extension NSString: Writable {
    /// Writes the string to a path atomically.
    ///
    /// - Parameter path: The path being written to.
    ///
    public func write(to path: Path) throws {
        try write(to: path, atomically: true)
    }

    /// Writes the string to a path with `NSUTF8StringEncoding` encoding.
    ///
    /// - Parameter path: The path being written to.
    /// - Parameter useAuxiliaryFile: If `true`, the data is written to an
    ///                               auxiliary file that is then renamed to the
    ///                               file. If `false`, the data is written to
    ///                               the file directly.
    ///
    public func write(to path: Path, atomically useAuxiliaryFile: Bool) throws {
        do {
            try self.write(toFile: path._safeRawValue,
                           atomically: useAuxiliaryFile,
                           encoding: String.Encoding.utf8.rawValue)
        } catch {
            throw FileKitError.writeToFileFail(path: path, error: error)
        }
    }

}

/*
 extension NSString: Readable {

 /// Creates a string from a path.
 public class func read(from path: Path) throws -> Self {
 let possibleContents = try? NSString(
 contentsOfFile: path._safeRawValue,
 encoding: String.Encoding.utf8.rawValue)
 guard let contents = possibleContents else {
 throw FileKitError.readFromFileFail(path: path)
 }
 return contents
 }
 }
 */
