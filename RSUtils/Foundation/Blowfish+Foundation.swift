//
//  Blowfish+Foundation.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

extension Blowfish {

    /// Initialize with CBC block mode.
    public convenience init(key: String, iv: String, padding: Padding = .pkcs7) throws {
        try self.init(key: key.bytes, blockMode: .CBC(iv: iv.bytes), padding: padding)
    }
}
