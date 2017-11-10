//
//  DataFile.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation
open class DataFile: File<Data> {
    
    /// Reads the file and returns its data.
    /// - Parameter options: A mask that specifies write options
    ///                      described in `Data.ReadingOptions`.
    ///
    /// - Throws: `FileKitError.ReadFromFileFail`
    /// - Returns: The data read from file.
    public func read(_ options: Data.ReadingOptions) throws -> Data {
        return try Data.read(from: path, options: options)
    }
    
    /// Writes data to the file.
    ///
    /// - Parameter data: The data to be written to the file.
    /// - Parameter options: A mask that specifies write options
    ///                      described in `Data.WritingOptions`.
    ///
    /// - Throws: `FileKitError.WriteToFileFail`
    ///
    public func write(_ data: Data, options: Data.WritingOptions) throws {
        try data.write(to: self.path, options: options)
    }
    
}

/// A representation of a filesystem data file,
/// with options to read or write.
///
/// The data type is Data.
open class DataFileWithOptions: DataFile {
    
    open var readingOptions: Data.ReadingOptions = []
    open var writingOptions: Data.WritingOptions?
    
    /// Initializes a file from a path with options.
    ///
    /// - Parameter path: The path to be created a text file from.
    /// - Parameter readingOptions: The options to be used to read file.
    /// - Parameter writingOptions: The options to be used to write file.
    ///                             If nil take into account `useAuxiliaryFile`
    public init(path: Path, readingOptions: Data.ReadingOptions = [], writingOptions: Data.WritingOptions? = nil) {
        self.readingOptions = readingOptions
        self.writingOptions = writingOptions
        super.init(path: path)
    }
    
    open override func read() throws -> Data {
        return try read(readingOptions)
    }
    
    open override func write(_ data: Data, atomically useAuxiliaryFile: Bool) throws {
        // If no option take into account useAuxiliaryFile
        let options: Data.WritingOptions = (writingOptions == nil) ?
            (useAuxiliaryFile ? Data.WritingOptions.atomic : [])
            : writingOptions!
        try self.write(data, options: options)
    }
}
