//
//  NSDate+format.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation

let DFM_AM_PM = "a"
let DFM_WDAY_S = "E"
let DFM_WDAY_L = "EEEE"
let DFM_WDAY_NUM_S = "e"
let DFM_WDAY_NUM_L = "ee"
let DFM_DAY_S = "d"
let DFM_DAY_L = "dd"
let DFM_MONTH_NUM_S = "M"
let DFM_MONTH_NUM_L = "MM"
let DFM_MONTH_S = "MMM"
let DFM_MONTH_L = "MMMM"
let DFM_YEAR_S = "yy"
let DFM_YEAR_L = "y"
let DFM_HOUR24_S = "H"
let DFM_HOUR24_L = "HH"
let DFM_HOUR12_S = "h"
let DFM_HOUR12_L = "hh"
let DFM_MINUTE_S = "m"
let DFM_MINUTE_L = "mm"
let DFM_SECOND_S = "s"
let DFM_SECOND_L = "ss"
let DFM_MILISECOND = "SSS"
let DFM_TZONE_S = "Z"
let DFM_TZONE_L = "ZZZZZ"
let DFM_LCL_TZONE_S = "z"
let DFM_LCL_TZONE_L = "ZZZZ"

//  The converted code is limited to 4 KB.
//  Upgrade your plan to remove this limitation.
extension NSDate {
    
    func commonComponents() -> DateComponents {
        return commonComponents(withLocaleIdentifier: "en_US", timezoneWitSecondsFromGMT: 0)
    }
    func commonLocalComponents() -> DateComponents {
        return commonComponents(withLocaleIdentifier: NSLocale.current.identifier, timezoneWitSecondsFromGMT: NSTimeZone.local.secondsFromGMT())
    }
    
    func commonDefaultComponents() -> DateComponents {
        let aCalender = Calendar(identifier: Calendar.Identifier.gregorian)
        return aCalender.dateComponents([.second, .minute, .hour, .day, .month, .year], from: self as Date)
        
    }
    
    func commonComponents(withLocaleIdentifier locale: String, timezoneWitSecondsFromGMT seconds: Int) -> DateComponents {
        var aCalender = Calendar(identifier: Calendar.Identifier.gregorian)
        if locale != "" {
            aCalender.locale = NSLocale(localeIdentifier: locale) as Locale
        }
        aCalender.timeZone = NSTimeZone(forSecondsFromGMT: seconds) as TimeZone
        return aCalender.dateComponents([.second, .minute, .hour, .day, .month, .year], from: self as Date)
        
    }
}

