//
//  BlockCipher.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
protocol BlockCipher: Cipher {
    static var blockSize: Int { get }
}
