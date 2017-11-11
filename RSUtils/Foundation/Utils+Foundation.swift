//
//  Utils+Foundation.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

func perf(_ text: String, closure: () -> Void) {
    let measurementStart = Date()

    closure()

    let measurementStop = Date()
    let executionTime = measurementStop.timeIntervalSince(measurementStart)

    print("\(text) \(executionTime)")
}
