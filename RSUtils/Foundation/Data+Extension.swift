//
//  Data+Extension.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

extension Data {

    /// Two octet checksum as defined in RFC-4880. Sum of all octets, mod 65536
    public func checksum() -> UInt16 {
        var s: UInt32 = 0
        var bytesArray = bytes
        for i in 0..<bytesArray.count {
            s = s + UInt32(bytesArray[i])
        }
        s = s % 65536
        return UInt16(s)
    }

    public func md5() -> Data {
        return Data(bytes: Digest.md5(bytes))
    }

    public func sha1() -> Data {
        return Data(bytes: Digest.sha1(bytes))
    }

    public func sha224() -> Data {
        return Data(bytes: Digest.sha224(bytes))
    }

    public func sha256() -> Data {
        return Data(bytes: Digest.sha256(bytes))
    }

    public func sha384() -> Data {
        return Data(bytes: Digest.sha384(bytes))
    }

    public func sha512() -> Data {
        return Data(bytes: Digest.sha512(bytes))
    }

    public func sha3(_ variant: SHA3.Variant) -> Data {
        return Data(bytes: Digest.sha3(bytes, variant: variant))
    }

    public func crc32(seed: UInt32? = nil, reflect: Bool = true) -> Data {
        return Data(bytes: Checksum.crc32(bytes, seed: seed, reflect: reflect).bytes())
    }

    public func crc16(seed: UInt16? = nil) -> Data {
        return Data(bytes: Checksum.crc16(bytes, seed: seed).bytes())
    }

    public func encrypt(cipher: Cipher) throws -> Data {
        return Data(bytes: try cipher.encrypt(bytes.slice))
    }

    public func decrypt(cipher: Cipher) throws -> Data {
        return Data(bytes: try cipher.decrypt(bytes.slice))
    }

    public func authenticate(with authenticator: Authenticator) throws -> Data {
        return Data(bytes: try authenticator.authenticate(bytes))
    }
}

extension Data {

    public var bytes: Array<UInt8> {
        return Array(self)
    }

    public func toHexString() -> String {
        return bytes.toHexString()
    }
}
