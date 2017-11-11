//
//  NSObject+dispatch.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation
extension NSObject {
    class func exec(onMain block: @escaping () -> Void) {
        execOnMain(block: block())
    }
    class func delay(toMain seconds: Double, exec block: @escaping () -> Void) {
        delayToMain(seconds: seconds, block: block())
    }
    func exec(onMain block: @escaping () -> Void) {
        execOnMain(block: block())
    }
    func delay(toMain seconds: Double, exec block: @escaping () -> Void) {
        delayToMain(seconds: seconds, block: block())
    }
}
func execOnMain(block: Void) {
    DispatchQueue.main.async {block}
}
func delayToMain(seconds: Double, block: Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(ino64_t(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
        block
    }
}
