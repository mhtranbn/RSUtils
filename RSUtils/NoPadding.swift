//
//  NoPadding.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
struct NoPadding: PaddingProtocol {

    init() {
    }

    func add(to data: Array<UInt8>, blockSize _: Int) -> Array<UInt8> {
        return data
    }

    func remove(from data: Array<UInt8>, blockSize _: Int?) -> Array<UInt8> {
        return data
    }
}
