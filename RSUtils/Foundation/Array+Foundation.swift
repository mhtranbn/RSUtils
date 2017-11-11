//
//  Array+Foundation.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

public extension Array where Element == UInt8 {

    public func toBase64() -> String? {
        return Data(bytes: self).base64EncodedString()
    }

    public init(base64: String) {
        self.init()

        guard let decodedData = Data(base64Encoded: base64) else {
            return
        }

        append(contentsOf: decodedData.bytes)
    }
}
