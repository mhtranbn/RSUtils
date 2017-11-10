//
//  CMDataTypes.swift
//  RSUtils
//
//  Created by mhtran on 11/10/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation
let FM_int = "%d"
let _FM_int = "d"
let FM_uint = "%u"
let _FM_uint = "u"
let FM_uoctal = "%o"
let _FM_uoctal = "o"
let FM_hex_uint = "%x"
let _FM_hex_uint = "x"
let FM_HEX_UINT = "%X"
let _FM_HEX_UINT = "X"
let FM_floating = "%f"
let _FM_floating = "f"
let FM_FLOATING = "%F"
let _FM_FLOATING = "F"
let FM_scientific = "%e"
let _FM_scientific = "e"
let FM_SCIENTIFIC = "%E"
let _FM_SCIENTIFIC = "E"
let FM_shortest_fe = "%g"
let _FM_shortest_fe = "g"
let FM_SHORTEST_FE = "%G"
let _FM_SHORTEST_FE = "G"
let FM_hex_floating = "%a"
let _FM_hex_floating = "a"
let FM_HEX_FLOATING = "%A"
let _FM_HEX_FLOATING = "A"
let FM_char = "%c"
let _FM_char = "c"
let FM_string = "%s"
let FM_pointer = "%p"
let FM_percent_char = "%%"
// Format for Foundation data (NS...)
let FM_BOOL = "%d"
let _FM_BOOL = "d"
#if __LP64__ && __LP64__
// NSInteger ~ long
let FM_NSInteger = "%ld"
let _FM_NSInteger = "ld"
let FM_NSUInteger = "%lu"
let _FM_NSUInteger = "lu"
// CGFloat ~ double
let FM_CGFloat = "%lf"
let _FM_CGFloat = "lf"
// Int32 ~ int
let FM_UInt32 = "%u"
let _FM_UInt32 = "u"
let FM_UInt32_hex = "%x"
let _FM_UInt32_hex = "x"
let FM_UInt32_HEX = "%X"
let _FM_UInt32_HEX = "X"
let FM_SInt32 = "%d"
let _FM_SInt32 = "d"
#else
// NSInteger ~ int
let FM_NSInteger = "%d"
let _FM_NSInteger = "d"
let FM_NSUInteger = "%u"
let _FM_NSUInteger = "u"
// CGFloat ~ float
let FM_CGFloat = "%f"
let _FM_CGFloat = "f"
// Int32 ~ long
let FM_UInt32 = "%lu"
let _FM_UInt32 = "lu"
let FM_UInt32_hex = "%lx"
let _FM_UInt32_hex = "lx"
let FM_UInt32_HEX = "%lX"
let _FM_UInt32_HEX = "lX"
let FM_SInt32 = "%ld"
let _FM_SInt32 = "ld"
#endif
// Int8 ~ char
let FM_UInt8 = "%u"
let _FM_UInt8 = "u"
let FM_SInt8 = "%d"
let _FM_SInt8 = "d"
// Int16 ~ short
let FM_UInt16 = "%hu"
let _FM_UInt16 = "hu"
let FM_UInt16_hex = "%hx"
let _FM_UInt16_hex = "hx"
let FM_UInt16_HEX = "%hX"
let _FM_UInt16_HEX = "hX"
let FM_SInt16 = "%hd"
let _FM_SInt16 = "hd"
#if _MSC_VER && !__MWERKS__ && _M_IX86
// Int64 ~ long
let FM_UInt64 = "%lu"
let _FM_UInt64 = "lu"
let FM_UInt64_hex = "%lx"
let _FM_UInt64_hex = "lx"
let FM_UInt64_HEX = "%lX"
let _FM_UInt64_HEX = "lX"
let FM_SInt64 = "%ld"
let _FM_SInt64 = "ld"
#else
// Int64 ~ long long
let FM_UInt64 = "%llu"
let _FM_UInt64 = "llu"
let FM_UInt64_hex = "%llx"
let _FM_UInt64_hex = "llx"
let FM_UInt64_HEX = "%llX"
let _FM_UInt64_HEX = "llX"
let FM_SInt64 = "%lld"
let _FM_SInt64 = "lld"
#endif

