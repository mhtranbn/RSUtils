//
//  String+Extension.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
extension String {

    public var bytes: Array<UInt8> {
        return data(using: String.Encoding.utf8, allowLossyConversion: true)?.bytes ?? Array(utf8)
    }

    public func md5() -> String {
        return bytes.md5().toHexString()
    }

    public func sha1() -> String {
        return bytes.sha1().toHexString()
    }

    public func sha224() -> String {
        return bytes.sha224().toHexString()
    }

    public func sha256() -> String {
        return bytes.sha256().toHexString()
    }

    public func sha384() -> String {
        return bytes.sha384().toHexString()
    }

    public func sha512() -> String {
        return bytes.sha512().toHexString()
    }

    public func sha3(_ variant: SHA3.Variant) -> String {
        return bytes.sha3(variant).toHexString()
    }

    public func crc32(seed: UInt32? = nil, reflect: Bool = true) -> String {
        return bytes.crc32(seed: seed, reflect: reflect).bytes().toHexString()
    }

    public func crc16(seed: UInt16? = nil) -> String {
        return bytes.crc16(seed: seed).bytes().toHexString()
    }

    /// - parameter cipher: Instance of `Cipher`
    /// - returns: hex string of bytes
    public func encrypt(cipher: Cipher) throws -> String {
        return try bytes.encrypt(cipher: cipher).toHexString()
    }

    /// - parameter cipher: Instance of `Cipher`
    /// - returns: base64 encoded string of encrypted bytes
    public func encryptToBase64(cipher: Cipher) throws -> String? {
        return try bytes.encrypt(cipher: cipher).toBase64()
    }

    // decrypt() does not make sense for String

    /// - parameter authenticator: Instance of `Authenticator`
    /// - returns: hex string of string
    public func authenticate<A: Authenticator>(with authenticator: A) throws -> String {
        return try bytes.authenticate(with: authenticator).toHexString()
    }
    
    public func with(_ attributes: StringAttributes) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
}
