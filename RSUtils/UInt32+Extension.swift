//
//  UInt32+Extension.swift
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

protocol _UInt32Type {}
extension UInt32: _UInt32Type {}

/** array of bytes */
extension UInt32 {

    @_specialize(exported: true, where T == ArraySlice<UInt8>)
    init<T: Collection>(bytes: T) where T.Element == UInt8, T.Index == Int {
        self = UInt32(bytes: bytes, fromIndex: bytes.startIndex)
    }

    @_specialize(exported: true, where T == ArraySlice<UInt8>)
    init<T: Collection>(bytes: T, fromIndex index: T.Index) where T.Element == UInt8, T.Index == Int {
        if bytes.isEmpty {
            self = 0
            return
        }

        let count = bytes.count

        let val0 = count > 0 ? UInt32(bytes[index.advanced(by: 0)]) << 24 : 0
        let val1 = count > 1 ? UInt32(bytes[index.advanced(by: 1)]) << 16 : 0
        let val2 = count > 2 ? UInt32(bytes[index.advanced(by: 2)]) << 8 : 0
        let val3 = count > 3 ? UInt32(bytes[index.advanced(by: 3)]) : 0

        self = val0 | val1 | val2 | val3
    }

    func bytes(totalBytes: Int = MemoryLayout<UInt32>.size) -> Array<UInt8> {
        return arrayOfBytes(value: self, length: totalBytes)
    }
}
