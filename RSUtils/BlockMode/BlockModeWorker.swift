//
//  BlockModeWorker.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
protocol BlockModeWorker {
    var cipherOperation: CipherOperationOnBlock { get }
    mutating func encrypt(_ plaintext: ArraySlice<UInt8>) -> Array<UInt8>
    mutating func decrypt(_ ciphertext: ArraySlice<UInt8>) -> Array<UInt8>
}
