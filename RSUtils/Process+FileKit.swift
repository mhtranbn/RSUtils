//
//  Process+FileKit.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
extension CommandLine {

    /// The working directory for the current process.
    public static var workingDirectory: Path {
        get {
            return Path.current
        }
        set {
            Path.current = newValue
        }
    }

}
