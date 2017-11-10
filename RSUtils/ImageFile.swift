//
//  ImageFile.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
/// A representation of a filesystem image file.
///
/// The data type is Image.
public typealias ImageFile = File<Image>

#endif
