//
//  HMAC+Foundation.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

extension HMAC {

    public convenience init(key: String, variant: HMAC.Variant = .md5) throws {
        self.init(key: key.bytes, variant: variant)
    }
}
