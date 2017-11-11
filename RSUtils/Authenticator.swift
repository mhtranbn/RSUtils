//
//  Authenticator.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
public protocol Authenticator {
    /// Calculate Message Authentication Code (MAC) for message.
    func authenticate(_ bytes: Array<UInt8>) throws -> Array<UInt8>
}
