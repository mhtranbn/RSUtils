//
//  NSDictionary+PropertyAttributes.m
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
#import "NSDictionary+PropertyAttributes.h"

@implementation NSDictionary (OBJPropertyAttribute)

-( NSString* )variableName {
    return [ self objectForKey:@"V" ];
}

-( OBJDataType )type {
    NSString *s = [ self typeDescription ];
    return [ OBJCommon dataTypeFromStringDescription:s ];
}

-( Class )typeClass {
    NSString *type = [ self typeDescription ];
    return [ OBJCommon classFromDataTypeDescription:type ];
}

-( NSString* )typeDescription {
    return [ self objectForKey:@"T" ];
}

-( BOOL )isReadOnly {
    return [ self.allKeys containsObject:@"R" ];
}

-( BOOL )isCopy {
    return [ self.allKeys containsObject:@"C" ];
}

-( BOOL )isRetain {
    return [ self.allKeys containsObject:@"&" ];
}

-( OBJPropertyAttributeMemoryType )valType {
    if ([ self.allKeys containsObject:@"C" ])
        return kObjPropAttrMemCopy;
    else if ([ self.allKeys containsObject:@"&" ])
        return kObjPropAttrMemRetainOrStrong;
    else if ([ self.allKeys containsObject:@"W" ])
        return kOBjPropAttrMemWeak;
    else
        return kObjPropAttrMemAssign;
}

-( BOOL )isNonAtomic {
    return [ self.allKeys containsObject:@"N" ];
}

-( BOOL )isDynamic {
    return [ self.allKeys containsObject:@"D" ];
}

-( BOOL )isWeakRef {
    return [ self.allKeys containsObject:@"W" ];
}

-( BOOL )isEligible {
    return [ self.allKeys containsObject:@"P" ];
}

-( NSString* )getterName {
    return [ self objectForKey:@"G" ];
}

-( NSString* )setterName {
    return [ self objectForKey:@"S" ];
}

-( NSString* )encoding {
    return [ self objectForKey:@"t" ];
}

@end
