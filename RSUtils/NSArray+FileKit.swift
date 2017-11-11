//
//  NSArray+FileKit.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

extension NSArray: ReadableWritable, WritableToFile {

    /// Returns an array read from the given path.
    ///
    /// - Parameter path: The path an array to be read from.
    public class func read(from path: Path) throws -> Self {
        guard let contents = self.init(contentsOfFile: path._safeRawValue) else {
            throw FileKitError.readFromFileFail(path: path, error: FileKitError.ReasonError.conversion(NSArray.self))
        }
        return contents
    }

}
