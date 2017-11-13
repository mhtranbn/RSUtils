//
//  NSParagraphStyle+Extension.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//


import UIKit

extension NSParagraphStyle {
    
    public func with(transformer: (NSMutableParagraphStyle) -> ()) -> NSParagraphStyle {
        let copy = mutableCopy() as! NSMutableParagraphStyle
        transformer(copy)
        return copy.copy() as! NSParagraphStyle
    }
    
}
