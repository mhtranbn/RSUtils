//
//  AlphaNumericRule.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation

/**
 `AlphaNumericRule` is a subclass of `CharacterSetRule`. It is used to verify that a field has a
 valid list of alphanumeric characters.
 */
public class AlphaNumericRule: CharacterSetRule {
    
    /**
     Initializes a `AlphaNumericRule` object to verify that field has valid set of alphanumeric characters.
     
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message: String = "Enter valid numeric characters") {
        super.init(characterSet: CharacterSet.alphanumerics, message: message)
    }
}
