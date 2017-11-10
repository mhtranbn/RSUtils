//
//  NSData+FileKit.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

extension NSData: ReadableWritable, WritableToFile {

    /// Returns data read from the given path.
    public class func read(from path: Path) throws -> Self {
        guard let contents = self.init(contentsOfFile: path._safeRawValue) else {
            throw FileKitError.readFromFileFail(path: path, error: FileKitError.ReasonError.conversion(NSData.self))
        }
        return contents
    }

    /// Returns data read from the given path using Data.ReadingOptions.
    public class func read(from path: Path, options: NSData.ReadingOptions) throws -> Self {
        do {
            return try self.init(contentsOfFile: path._safeRawValue, options: options)
        } catch {
            throw FileKitError.readFromFileFail(path: path, error: error)
        }
    }

}
