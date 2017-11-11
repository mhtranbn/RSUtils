//
//  Rabbit+Foundation.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

extension Rabbit {

    public convenience init(key: String) throws {
        try self.init(key: key.bytes)
    }

    public convenience init(key: String, iv: String) throws {
        try self.init(key: key.bytes, iv: iv.bytes)
    }
}
