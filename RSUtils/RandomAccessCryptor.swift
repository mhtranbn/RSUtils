//
//  RandomAccessCryptor.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
public protocol RandomAccessCryptor: Updatable {
    /// Seek to position in file, if block mode allows random access.
    ///
    /// - parameter to: new value of counter
    ///
    /// - returns: true if seek succeed
    @discardableResult mutating func seek(to: Int) -> Bool
}
