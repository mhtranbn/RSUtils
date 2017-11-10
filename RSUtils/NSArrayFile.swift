
//
//  NSArrayFile.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation
/// A representation of a filesystem array file.
///
/// The data type is NSArray.
public typealias NSArrayFile = File<NSArray>

/// A representation of a filesystem array file.
///
/// The data type is Array.
public typealias ArrayFile<T> = File<[T]>
