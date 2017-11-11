//
//  Bit.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
public enum Bit: Int {
    case zero
    case one
}

extension Bit {

    func inverted() -> Bit {
        return self == .zero ? .one : .zero
    }
}
