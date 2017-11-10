//
//  NSDictionary+FileKit.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

extension NSDictionary: ReadableWritable, WritableToFile {

    /// Returns a dictionary read from the given path.
    public class func read(from path: Path) throws -> Self {
        guard let contents = self.init(contentsOfFile: path._safeRawValue) else {
            throw FileKitError.readFromFileFail(path: path, error: FileKitError.ReasonError.conversion(NSDictionary.self))
        }
        return contents
    }

}
