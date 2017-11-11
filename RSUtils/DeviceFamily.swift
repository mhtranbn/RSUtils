//
//  DeviceFamily.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
public enum DeviceFamily: String {

    case iPhone
    case iPod
    case iPad
    case simulator
    case unknown

    public init(rawValue: String) {
        switch rawValue {
        case "iPhone":
            self = .iPhone
        case "iPod":
            self = .iPod
        case "iPad":
            self = .iPad
        case "x86_64", "i386":
            self = .simulator
        default:
            self = .unknown
        }
    }
}
