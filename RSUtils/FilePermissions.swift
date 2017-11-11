//
//  FilePermissions.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation
public struct FilePermissions: OptionSet, CustomStringConvertible {
    
    /// The file can be read from.
    public static let read = FilePermissions(rawValue: 1)
    
    /// The file can be written to.
    public static let write = FilePermissions(rawValue: 2)
    
    /// The file can be executed.
    public static let execute = FilePermissions(rawValue: 4)
    
    /// All FilePermissions
    public static let all: [FilePermissions] =  [.read, .write, .execute]
    
    /// The raw integer value of `self`.
    public let rawValue: Int
    
    /// A textual representation of `self`.
    public var description: String {
        var description = ""
        for permission in FilePermissions.all {
            if self.contains(permission) {
                description += !description.isEmpty ? ", " : ""
                if permission == .read {
                    description += "Read"
                } else if permission == .write {
                    description += "Write"
                } else if permission == .execute {
                    description += "Execute"
                }
            }
        }
        return String(describing: type(of: self)) + "[" + description + "]"
    }
    
    /// Creates a set of file permissions.
    ///
    /// - Parameter rawValue: The raw value to initialize from.
    ///
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    /// Creates a set of permissions for the file at `path`.
    ///
    /// - Parameter path: The path to the file to create a set of persmissions for.
    ///
    public init(forPath path: Path) {
        var permissions = FilePermissions(rawValue: 0)
        if path.isReadable { permissions.formUnion(.read) }
        if path.isWritable { permissions.formUnion(.write) }
        if path.isExecutable { permissions.formUnion(.execute) }
        self = permissions
    }
    
    /// Creates a set of permissions for `file`.
    ///
    /// - Parameter file: The file to create a set of persmissions for.
    public init<DataType>(forFile file: File<DataType>) {
        self.init(forPath: file.path)
    }
    
}
