//
//  DigestType.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
internal protocol DigestType {
    func calculate(for bytes: Array<UInt8>) -> Array<UInt8>
}
