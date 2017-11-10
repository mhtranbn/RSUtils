//
//  DirectoryEnumerator.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation
public struct DirectoryEnumerator: IteratorProtocol {
    
    fileprivate let _path: Path, _enumerator: FileManager.DirectoryEnumerator?
    
    /// Creates a directory enumerator for the given path.
    ///
    /// - Parameter path: The path a directory enumerator to be created for.
    public init(path: Path) {
        _path = path
        _enumerator = FileManager().enumerator(atPath: path._safeRawValue)
    }
    
    /// Returns the next path in the enumeration.
    public func next() -> Path? {
        guard let next = _enumerator?.nextObject() as? String else {
            return nil
        }
        return _path + next
    }
    
    /// Skip recursion into the most recently obtained subdirectory.
    public func skipDescendants() {
        _enumerator?.skipDescendants()
    }
}
