//
//  FileKit.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation
public enum FileKitInfo {
    
    /// The current version.
    ///
    /// FileKit follows [Semantic Versioning v2.0.0](http://semver.org/).
    public static let version = "v5.0.0"
    
    /// The current release.
    public static let release = 12
    
    /// FileKit is licensed under the [MIT License](https://opensource.org/licenses/MIT).
    public static let license = "MIT"
    
    /// A brief description of FileKit.
    public static let description = "A Swift framework that allows for simple and expressive file management."
    
    /// Where the project can be found.
    public static let projectURL = "https://github.com/nvzqz/FileKit"
    
}

import Foundation

public struct FileKit {
    
    /// Shared json decoder instance
    public static var jsonDecoder = JSONDecoder()
    /// Shared json encoder instance
    public static var jsonEncoder = JSONEncoder()
    /// Shared property list decoder instance
    public static var propertyListDecoder = PropertyListDecoder()
    /// Shared property list encoder instance
    public static var propertyListEncoder = PropertyListEncoder()
    
}

extension FileKit {
    
    /// Write an `Encodable` object to path
    ///
    /// - Parameter codable: The codable object to write.
    /// - Parameter path: The destination path for write operation.
    /// - Parameter encoder: A specific JSON encoder (default: FileKit.jsonEncoder).
    ///
    public static func write<T: Encodable>(_ codable: T, to path: Path, with encoder: JSONEncoder = FileKit.jsonEncoder) throws {
        do {
            let data = try encoder.encode(codable)
            try DataFile(path: path).write(data)
        } catch let error as FileKitError {
            throw error
        } catch {
            throw FileKitError.writeToFileFail(path: path, error: error)
        }
    }
    
    /// Read an `Encodable` object from path
    ///
    /// - Parameter path: The destination path for write operation.
    /// - Parameter decoder: A specific JSON decoder (default: FileKit.jsonDecoder).
    ///
    public static func read<T: Decodable>(from path: Path, with decoder: JSONDecoder = FileKit.jsonDecoder) throws -> T {
        let data = try DataFile(path: path).read()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw FileKitError.readFromFileFail(path: path, error: error)
        }
    }
    
}
