//
//  Bundle+FileKit.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation
import Foundation

extension Bundle {
    
    /// Returns an NSBundle for the given directory path.
    public convenience init?(path: Path) {
        self.init(path: path.absolute.rawValue)
    }
    
}
