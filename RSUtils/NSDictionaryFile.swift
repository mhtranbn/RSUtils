//
//  NSDictionaryFile.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation
public typealias NSDictionaryFile = File<NSDictionary>

/// A representation of a filesystem dictionary file.
///
/// The data type is DictionaryFile.
public typealias DictionaryFile<K: Hashable, V> = File<[K: V]>
