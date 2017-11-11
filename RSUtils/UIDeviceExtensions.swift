//
//  UIDeviceExtensions.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import UIKit

public extension UIDeviceComplete where Base == UIDevice {

    private var identifier: Identifier? {
        return System.name.flatMap {
            return Identifier($0)
        }
    }

    /// Device family i.e iPhone, iPod, iPad
    var deviceFamily: DeviceFamily {
        return identifier.flatMap { $0.type } ?? .unknown
    }

    /// Specific model i.e iphone7 or iPhone7s
    var deviceModel: DeviceModel {
        return identifier.flatMap { DeviceModel(identifier: $0) } ?? .unknown
    }

    /// Common name for device i.e "iPhone 7 Plus"
    var commonDeviceName: String {
        return identifier?.description ?? "unknown"
    }

    /// Device family iPhone
    var isIphone: Bool {
        return deviceFamily == .iPhone
    }

    /// Device family iPad
    var isIpad: Bool {
        return deviceFamily == .iPad
    }

    /// Deivce family iPod
    var isIpod: Bool {
        return deviceFamily == .iPod
    }

    /// Simulator
    var isSimulator: Bool {
        return deviceFamily == .simulator
    }
}


// MARK: - Screen Size Detection

public extension UIDeviceComplete where Base == UIDevice {
    var screenSize: Screen {
        let scale: Double = Double(UIScreen.main.scale)
        let width: Double = Double(UIScreen.main.bounds.width)
        let height: Double = Double(UIScreen.main.bounds.height)

        return Screen(width: width, height: height, scale: scale)
    }
}
