
//
//  Data+FileKit.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation
extension Data: ReadableWritable {
    
    /// Returns data read from the given path.
    public static func read(from path: Path) throws -> Data {
        do {
            return try self.init(contentsOf: path.url, options: [])
        } catch {
            throw FileKitError.readFromFileFail(path: path, error: error)
        }
    }
    
    /// Returns data read from the given path using Data.ReadingOptions.
    public static func read(from path: Path, options: Data.ReadingOptions) throws -> Data {
        do {
            return try self.init(contentsOf: path.url, options: options)
        } catch {
            throw FileKitError.readFromFileFail(path: path, error: error)
        }
    }
    
    /// Writes `self` to a Path.
    public func write(to path: Path) throws {
        try write(to: path, atomically: true)
    }
    
    /// Writes `self` to a path.
    ///
    /// - Parameter path: The path being written to.
    /// - Parameter useAuxiliaryFile: If `true`, the data is written to an
    ///                               auxiliary file that is then renamed to the
    ///                               file. If `false`, the data is written to
    ///                               the file directly.
    ///
    public func write(to path: Path, atomically useAuxiliaryFile: Bool) throws {
        let options: Data.WritingOptions = useAuxiliaryFile ? [.atomic] : []
        try self.write(to: path, options: options)
    }
    
    /// Writes `self` to a path.
    ///
    /// - Parameter path: The path being written to.
    /// - Parameter options: writing options.
    ///
    public func write(to path: Path, options: Data.WritingOptions) throws {
        do {
            try self.write(to: path.url, options: options)
        } catch {
            throw FileKitError.writeToFileFail(path: path, error: error)
        }
    }
    
}
