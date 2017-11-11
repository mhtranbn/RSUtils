//
//  RelativePathType.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

/// The type attribute for a relative path.
public enum RelativePathType: String {

    /// path like "dir/path".
    case normal

    /// path like "." and "".
    case current

    /// path like "../path".
    case ancestor

    /// path like "..".
    case parent

    /// path like "/path".
    case absolute

}
