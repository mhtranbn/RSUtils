//
//  System.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
class System {
    static var name: String? {
        var systemInfo = utsname()
        uname(&systemInfo)

        // TODO: Find the source of the extra newlines that are getting appended in the end
        // the cause of this could just be a larger buffer than nessisary getting allocated
        // and the rest of the string being zeroed out.
        let encoding: UInt = String.Encoding.ascii.rawValue
        if let string = NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: encoding) {
            return (string as String).components(separatedBy: "\0").first
        }
        return nil
    }
}
