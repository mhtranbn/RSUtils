//
//  Generics.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
@_specialize(exported: true, where T == UInt8)
func integerFrom<T: FixedWidthInteger>(_ bits: Array<Bit>) -> T {
    var bitPattern: T = 0
    for idx in bits.indices {
        if bits[idx] == Bit.one {
            let bit = T(UInt64(1) << UInt64(idx))
            bitPattern = bitPattern | bit
        }
    }
    return bitPattern
}

/// Array of bytes. Caution: don't use directly because generic is slow.
///
/// - parameter value: integer value
/// - parameter length: length of output array. By default size of value type
///
/// - returns: Array of bytes
@_specialize(exported: true, where T == Int)
@_specialize(exported: true, where T == UInt)
@_specialize(exported: true, where T == UInt8)
@_specialize(exported: true, where T == UInt16)
@_specialize(exported: true, where T == UInt32)
@_specialize(exported: true, where T == UInt64)
func arrayOfBytes<T: FixedWidthInteger>(value: T, length totalBytes: Int = MemoryLayout<T>.size) -> Array<UInt8> {
    let valuePointer = UnsafeMutablePointer<T>.allocate(capacity: 1)
    valuePointer.pointee = value

    let bytesPointer = UnsafeMutablePointer<UInt8>(OpaquePointer(valuePointer))
    var bytes = Array<UInt8>(repeating: 0, count: totalBytes)
    for j in 0..<min(MemoryLayout<T>.size, totalBytes) {
        bytes[totalBytes - 1 - j] = (bytesPointer + j).pointee
    }

    valuePointer.deinitialize()
    valuePointer.deallocate(capacity: 1)

    return bytes
}
