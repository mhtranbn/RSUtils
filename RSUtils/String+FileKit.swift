//
//  String+FileKit.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

var ReadableWritableStringEncoding = String.Encoding.utf8

/// Allows String to be used as a ReadableWritable.
extension String: ReadableWritable {

    /// Creates a string from a path.
    public static func read(from path: Path) throws -> String {
        do {
            return try String(contentsOfFile: path._safeRawValue,
                              encoding: ReadableWritableStringEncoding)
        } catch {
            throw FileKitError.readFromFileFail(path: path, error: error)
        }
    }

    /// Writes the string to a path atomically.
    ///
    /// - Parameter path: The path being written to.
    ///
    public func write(to path: Path) throws {
        try write(to: path, atomically: true)
    }

    /// Writes the string to a path with `ReadableWritableStringEncoding` encoding.
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
                encoding: ReadableWritableStringEncoding)
        } catch {
            throw FileKitError.writeToFileFail(path: path, error: error)
        }
    }

}
