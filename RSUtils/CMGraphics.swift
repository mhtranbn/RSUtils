
//
//  CMGraphics.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

func NSIntegerRandomNumberBetween(minValue: Int, maxValue: Int) -> Int {
    let i: Int = Int(arc4random()) % (maxValue + Int(1) - minValue)
    return i + minValue
}

func CGPointCenterOfRect(rect: CGRect) -> CGPoint {
    return CGPoint(x: rect.origin.x + rect.size.width / 2, y: rect.origin.y + rect.size.height / 2)
}

func CGPointDistanceBetween2Points(point1: CGPoint, point2: CGPoint) -> Double {
    return Double(sqrt(pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2)))
}

func CGRectMoveToCenter(rect: CGRect, center: CGPoint) -> CGRect {
    var rect = rect
    rect.origin.x = center.x - rect.size.width / 2
    rect.origin.y = center.y - rect.size.height / 2
    return rect
}

func CGRectMakeRectCenterOfRect(rect: CGRect, size: CGSize) -> CGRect {
    var rect = rect
    rect.origin.x += (rect.size.width - size.width) / 2
    rect.origin.y += (rect.size.height - size.height) / 2
    rect.size = size
    return rect
}

func CGSizeMakeFillSize(sizeToFill: CGSize, sizeRatio: CGSize) -> CGSize {
    var result: CGSize = sizeToFill
    result.height = result.width * sizeRatio.height / sizeRatio.width
    if result.height < sizeToFill.height {
        result.height = sizeToFill.height
        result.width = result.height * sizeRatio.width / sizeRatio.height
    }
    return result
}

func CGRectMakeFillWithSize(rect: CGRect, size: CGSize) -> CGRect {
    let fillSize: CGSize = CGSizeMakeFillSize(sizeToFill: rect.size, sizeRatio: size)
    return CGRectMakeRectCenterOfRect(rect: rect, size: fillSize)
}

func CGSizeMakeFitSize(sizeToFit: CGSize, sizeRatio: CGSize) -> CGSize {
    var result: CGSize = sizeToFit
    result.height = result.width * sizeRatio.height / sizeRatio.width
    if result.height > sizeToFit.height {
        result.height = sizeToFit.height
        result.width = result.height * sizeRatio.width / sizeRatio.height
    }
    return result
}

func CGRectMakeFitWithSize(rect: CGRect, size: CGSize) -> CGRect {
    let fitSize: CGSize = CGSizeMakeFitSize(sizeToFit: rect.size, sizeRatio: size)
    return CGRectMakeRectCenterOfRect(rect: rect, size: fitSize)
}

func CGSizeDiagonalLength(size: CGSize) -> CGFloat {
    return sqrt(pow(size.width, 2) + pow(size.height, 2))
}

func CGSizeMakeFitCircle(radius: CGFloat, sizeRatio: CGSize) -> CGSize {
    var sizeRatio = sizeRatio
    let dia: CGFloat = CGSizeDiagonalLength(size: sizeRatio) / 2
    let ratio: CGFloat = radius / dia
    sizeRatio.width *= ratio
    sizeRatio.height *= ratio
    return sizeRatio
}

func CGRectMakeFitCircle(center: CGPoint, radius: CGFloat, sizeRatio: CGSize) -> CGRect {
    var sizeRatio = sizeRatio
    sizeRatio = CGSizeMakeFitCircle(radius: radius, sizeRatio: sizeRatio)
    var result: CGRect = CGRect.zero
    result.size = sizeRatio
    return CGRectMoveToCenter(rect: result, center: center)
}

//  The converted code is limited to 4 KB.
//  Upgrade your plan to remove this limitation.
func CGSizeMakeFillCircle(radius: CGFloat, sizeRatio: CGSize) -> CGSize {
    let dia: CGFloat = radius * 2
    return CGSizeMakeFillSize(sizeToFill: CGSize(width: dia, height: dia), sizeRatio: sizeRatio)
}
//  The converted code is limited to 4 KB.
//  Upgrade your plan to remove this limitation.
func CGRectMakeFillCircle(center: CGPoint, radius: CGFloat, sizeRatio: CGSize) -> CGRect {
    var sizeRatio = sizeRatio
    sizeRatio = CGSizeMakeFillCircle(radius: radius, sizeRatio: sizeRatio)
    var result: CGRect = CGRect.zero
    result.size = sizeRatio
    return CGRectMoveToCenter(rect: result, center: center)
}
//  The converted code is limited to 4 KB.
//  Upgrade your plan to remove this limitation.
func RGB(red: UInt8, green: UInt8, blue: UInt8) -> UIColor {
    return UIColor(red: CGFloat((red / 255)), green: CGFloat((green / 255)), blue: CGFloat((blue / 255)), alpha: 1.0)
}
//  The converted code is limited to 4 KB.
//  Upgrade your plan to remove this limitation.
func RGBA(red: UInt8, green: UInt8, blue: UInt8, alpha: Float) -> UIColor {
    return UIColor(red: CGFloat((red / 255)), green: CGFloat((green / 255)), blue: CGFloat((blue / 255)), alpha: CGFloat(alpha))
}

//  The converted code is limited to 4 KB.
//  Upgrade your plan to remove this limitation.
func ARGB(hexa: UInt32) -> UIColor {
    var alpha = Float((((hexa >> 24) & 0xff) * UInt32(1.0)))
    alpha = alpha / 0xff
    let red = UInt8(((hexa >> 16) & 0xff))
    let green = UInt8(((hexa >> 8) & 0xff))
    let blue = UInt8((hexa & 0xff))
    return RGBA(red: red, green: green, blue: blue, alpha: alpha)
}
//  The converted code is limited to 4 KB.
//  Upgrade your plan to remove this limitation.
// 2D graphic Math
func CGVectorFixAngleSinCosValue(a: Double) -> Double {
    var a = a
    if a > 1.0 {
        a = 1.0
    }
    if a < -1.0 {
        a = -1.0
    }
    return a
}
func CGVectorOX() -> CGVector {
    return CGVector(dx: 1, dy: 0)
}
func CGVectorOY() -> CGVector {
    return CGVector(dx: 0, dy: 1)
}
func CGVectorMakeFromPoint(p: CGPoint) -> CGVector {
    return CGVectorMakeFromPoints(p0: CGPoint.zero, p1: p)
}
func CGVectorMakeFromPoints(p0: CGPoint, p1: CGPoint) -> CGVector {
    return CGVector(dx: p1.x - p0.x, dy: p1.y - p0.y)
}
func CGVectorGetLength(vector: CGVector) -> Double {
    return CGPointDistanceBetween2Points(point1: CGPoint(x: vector.dx, y: vector.dy), point2: CGPoint.zero)
}
func CGVectorGetCrossProduct(vec0: CGVector, vec1: CGVector) -> Double {
    return Double((vec0.dx * vec1.dy - vec0.dy * vec1.dx))
}
func CGVectorGetDotProduct(vec0: CGVector, vec1: CGVector) -> Double {
    return Double((vec0.dx * vec1.dx + vec0.dy * vec1.dy))
}
func CGVectorGetAngleBetweenVectors(vec0: CGVector, vec1: CGVector) -> Double {
    let dot: Double = CGVectorGetDotProduct(vec0: vec0, vec1: vec1)
    let l1: Double = CGVectorGetLength(vector: vec0)
    let l2: Double = CGVectorGetLength(vector: vec1)
    let cross: Double = CGVectorGetCrossProduct(vec0: vec0, vec1: vec1)
    var angle: Double = CGVectorFixAngleSinCosValue(a: dot / (l1 * l2))
    // Still reason of double division error
    angle = acos(angle)
    if cross <= 0 {
        return angle
    }
    else {
        return 2 * .pi - angle
    }
}
func CGCheckPointMiddle(pt0: CGPoint, middlePt: CGPoint, pt1: CGPoint) -> Bool {
    return middlePt.x <= max(pt0.x, pt1.x) && middlePt.x >= min(pt0.x, pt1.x) && middlePt.y <= max(pt0.y, pt1.y) && middlePt.y >= min(pt0.y, pt1.y)
}
//  The converted code is limited to 4 KB.
//  Upgrade your plan to remove this limitation.
//  The converted code is limited to 4 KB.
//  Upgrade your plan to remove this limitation.
enum CGIntersectionType : Int {
    /// 2 lines are same
    case kCGCollinear
    /// 2 lines are parallel
    case kCGParallel
    /// 2 lines have a common point
    case kCGIntersection
    /// Can not determine
    case kCGUnknown
}

func CGGetIntersectionOfSegments(p00: CGPoint, p01: CGPoint, p10: CGPoint, p11: CGPoint, intersection: CGPoint) -> CGIntersectionType {
    var intersection = intersection
    let vec0: CGVector = CGVectorMakeFromPoints(p0: p00, p1: p01)
    let vec1: CGVector = CGVectorMakeFromPoints(p0: p10, p1: p11)
    let vec2: CGVector = CGVectorMakeFromPoints(p0: p00, p1: p10)
    let cross0: Double = CGVectorGetCrossProduct(vec0: vec0, vec1: vec1)
    let abs0: Double = abs(cross0)
    let cross1: Double = CGVectorGetCrossProduct(vec0: vec2, vec1: vec0)
    let abs1: Double = abs(cross1)
    let zero: Double = pow(10, -10)
    if abs0 < zero && abs1 < zero {
        return CGIntersectionType.kCGCollinear
    }
    // 2 segments are collinear
    if abs0 < zero && abs1 >= zero {
        return CGIntersectionType.kCGParallel
    }
    // 2 segements are parallel
    let cross2: Double = CGVectorGetCrossProduct(vec0: vec2, vec1: vec1)
    let t: Double = cross2 / cross0
    let u: Double = cross1 / cross0
    if abs0 >= zero && (0 <= t && t <= 1) && (0 <= u && u <= 1) {
        intersection.x = p00.x + CGFloat(t) * vec0.dx
        intersection.y = p00.y + CGFloat(t) * vec0.dy
        return CGIntersectionType.kCGIntersection
    }
    return CGIntersectionType.kCGUnknown
}
func CGPointIsOnEdgeOfRect(pt: CGPoint, rect: CGRect) -> Bool {
    var pt0: CGPoint = rect.origin
    var pt1 = CGPoint(x: rect.origin.x, y: rect.maxY)
    if pt.x == pt0.x && CGCheckPointMiddle(pt0: pt0, middlePt: pt, pt1: pt1) {
        return true
    }
    pt0 = rect.origin
    pt1 = CGPoint(x: rect.maxX, y: rect.origin.y)
    if pt.y == pt0.y && CGCheckPointMiddle(pt0: pt0, middlePt: pt, pt1: pt1) {
        return true
    }
    pt0 = CGPoint(x: rect.origin.x, y: rect.maxY)
    pt1 = CGPoint(x: rect.maxX, y: rect.maxY)
    if pt.y == pt0.y && CGCheckPointMiddle(pt0: pt0, middlePt: pt, pt1: pt1) {
        return true
    }
    pt0 = CGPoint(x: rect.maxX, y: rect.origin.y)
    pt1 = CGPoint(x: rect.maxX, y: rect.maxY)
    if pt.x == pt0.x && CGCheckPointMiddle(pt0: pt0, middlePt: pt, pt1: pt1) {
        return true
    }
    return false
}
func CGGetIntersectionOfSegmentRect(pt0: CGPoint, pt1: CGPoint, rect: CGRect, intersection: CGPoint) -> Bool {
    var intersection = intersection
    if pt0.equalTo(pt1) {
        if CGPointIsOnEdgeOfRect(pt: pt0, rect: rect) {
            intersection = pt0
            return true
        }
    }
    else {
        let interPoint = CGPoint.zero
        var type: CGIntersectionType = CGGetIntersectionOfSegments(p00: pt0, p01: pt1, p10: rect.origin, p11: CGPoint(x: rect.origin.x, y: rect.maxY), intersection: interPoint)
        if type == CGIntersectionType.kCGIntersection && CGCheckPointMiddle(pt0: pt0, middlePt: interPoint, pt1: pt1) {
            intersection = interPoint
            return true
        }
        type = CGGetIntersectionOfSegments(p00: pt0, p01: pt1, p10: rect.origin, p11: CGPoint(x: rect.maxX, y: rect.origin.y), intersection: interPoint)
        if type == CGIntersectionType.kCGIntersection && CGCheckPointMiddle(pt0: pt0, middlePt: interPoint, pt1: pt1) {
            intersection = interPoint
            return true
        }
        type = CGGetIntersectionOfSegments(p00: pt0, p01: pt1, p10: CGPoint(x: rect.maxX, y: rect.maxY), p11: CGPoint(x: rect.origin.x, y: rect.maxY), intersection: interPoint)
        if type == CGIntersectionType.kCGIntersection && CGCheckPointMiddle(pt0: pt0, middlePt: interPoint, pt1: pt1) {
            intersection = interPoint
            return true
        }
        type = CGGetIntersectionOfSegments(p00: pt0, p01: pt1, p10: CGPoint(x: rect.maxX, y: rect.maxY), p11: CGPoint(x: rect.origin.x, y: rect.maxY), intersection: interPoint)
        if type == CGIntersectionType.kCGIntersection && CGCheckPointMiddle(pt0: pt0, middlePt: interPoint, pt1: pt1) {
            intersection = interPoint
            return true
        }
    }
    return false
}
