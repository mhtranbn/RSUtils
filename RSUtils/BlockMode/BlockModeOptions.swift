//
//  BlockModeOptions.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
struct BlockModeOptions: OptionSet {
    let rawValue: Int

    static let none = BlockModeOptions(rawValue: 0)
    static let initializationVectorRequired = BlockModeOptions(rawValue: 1)
    static let paddingRequired = BlockModeOptions(rawValue: 2)
}
