//
//  Cryptors.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
#if os(Linux) || os(Android) || os(FreeBSD)
    import Glibc
#else
    import Darwin
#endif

/// Worker cryptor/decryptor of `Updatable` types
public protocol Cryptors: class {
    associatedtype EncryptorType: Updatable
    associatedtype DecryptorType: Updatable

    /// Cryptor suitable for encryption
    func makeEncryptor() throws -> EncryptorType

    /// Cryptor suitable for decryption
    func makeDecryptor() throws -> DecryptorType

    /// Generate array of random bytes. Helper function.
    static func randomIV(_ blockSize: Int) -> Array<UInt8>
}

extension Cryptors {

    public static func randomIV(_ blockSize: Int) -> Array<UInt8> {
        var randomIV: Array<UInt8> = Array<UInt8>()
        randomIV.reserveCapacity(blockSize)
        for randomByte in RandomBytesSequence(size: blockSize) {
            randomIV.append(randomByte)
        }
        return randomIV
    }
}
