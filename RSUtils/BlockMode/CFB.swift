//
//  CFB.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
struct CFBModeWorker: BlockModeWorker {
    let cipherOperation: CipherOperationOnBlock
    private let iv: ArraySlice<UInt8>
    private var prev: ArraySlice<UInt8>?

    init(iv: ArraySlice<UInt8>, cipherOperation: @escaping CipherOperationOnBlock) {
        self.iv = iv
        self.cipherOperation = cipherOperation
    }

    mutating func encrypt(_ plaintext: ArraySlice<UInt8>) -> Array<UInt8> {
        guard let ciphertext = cipherOperation(prev ?? iv) else {
            return Array(plaintext)
        }
        prev = xor(plaintext, ciphertext.slice)
        return Array(prev ?? [])
    }

    mutating func decrypt(_ ciphertext: ArraySlice<UInt8>) -> Array<UInt8> {
        guard let plaintext = cipherOperation(prev ?? iv) else {
            return Array(ciphertext)
        }
        let result: Array<UInt8> = xor(plaintext, ciphertext)
        prev = ciphertext
        return result
    }
}
