//
//  RandomAccessBlockModeWorker.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
protocol RandomAccessBlockModeWorker: BlockModeWorker {
    var counter: UInt { set get }
}
