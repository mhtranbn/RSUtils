//
//  Cipher.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
public enum CipherError: Error {
    case encrypt
    case decrypt
}

public protocol Cipher: class {
    /// Encrypt given bytes at once
    ///
    /// - parameter bytes: Plaintext data
    /// - returns: Encrypted data
    func encrypt(_ bytes: ArraySlice<UInt8>) throws -> Array<UInt8>
    func encrypt(_ bytes: Array<UInt8>) throws -> Array<UInt8>

    /// Decrypt given bytes at once
    ///
    /// - parameter bytes: Ciphertext data
    /// - returns: Plaintext data
    func decrypt(_ bytes: ArraySlice<UInt8>) throws -> Array<UInt8>
    func decrypt(_ bytes: Array<UInt8>) throws -> Array<UInt8>
}

extension Cipher {
    public func encrypt(_ bytes: Array<UInt8>) throws -> Array<UInt8> {
        return try encrypt(bytes.slice)
    }

    public func decrypt(_ bytes: Array<UInt8>) throws -> Array<UInt8> {
        return try decrypt(bytes.slice)
    }
}
