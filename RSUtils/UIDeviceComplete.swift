//
//  UIDeviceComplete.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import UIKit

public final class UIDeviceComplete<Base> {
    let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol UIDeviceCompleteCompatible {
    associatedtype CompatibleType

    var dc: CompatibleType { get }
}

public extension UIDeviceCompleteCompatible {
    public var dc: UIDeviceComplete<Self> {
        return UIDeviceComplete(self)
    }
}

extension UIDevice: UIDeviceCompleteCompatible { }
