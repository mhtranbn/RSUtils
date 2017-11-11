//
//  Mass.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

/**
 *  Mass formatter.
 */
public enum Mass: NumberFormatter {
    case generic // Mass of a generic object in kg. Display in current locale.
    case person // Mass of a person in kg. Display in current locale.
    
    /// Modifier
    public var modifier: String {
        switch self {
        case .generic:
            return MassFormatterGenericKey
        case .person:
            return MassFormatterPersonKey
        }
    }
    
    /// Type enum
    public var type: NumberFormatterType {
        return .mass
    }
    
    /// NSNumberFormatter style
    public var style: Foundation.NumberFormatter.Style? {
        return .none
    }
}
