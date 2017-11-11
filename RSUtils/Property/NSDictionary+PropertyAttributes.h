//
//  NSDictionary+PropertyAttributes.h
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
#import "OBJProperty.h"
#import "OBJCommon.h"

typedef NS_ENUM( NSUInteger, OBJPropertyAttributeMemoryType ) {
    kObjPropAttrMemAssign,
    kObjPropAttrMemCopy,
    kObjPropAttrMemRetainOrStrong,
    kOBjPropAttrMemWeak
};

@interface NSDictionary (OBJPropertyAttribute)

/**
 *	@brief	Internal variable name which stores value of class property
 */
-( nullable NSString* )variableName;
/**
 *  Full type description string
 */
-( nullable NSString* )typeDescription;
/**
 *	Data type of class property
 */
-( OBJDataType )type;
/**
 *  If property type is object, try get class from typeDescription
 *
 *  @return May be nil
 */
-( nullable Class )typeClass;
/**
 *	@brief	Class property is read-only
 */
-( BOOL )isReadOnly;
-( BOOL )isCopy;
-( BOOL )isRetain;
/**
 *	@brief	Class property value assigning type
 */
-( OBJPropertyAttributeMemoryType )valType;
/**
 *	@brief	Class property is non-atomic
 */
-( BOOL )isNonAtomic;
/**
 *	@brief	Class property is dynamic
 */
-( BOOL )isDynamic;
/**
 *	@brief	Class property is weak reference
 */
-( BOOL )isWeakRef;
/**
 *	@brief	Class property is eligible
 */
-( BOOL )isEligible;
/**
 *	@brief	Name of method to get property value
 */
-( nullable NSString* )getterName;
/**
 *	@brief	Name of method to set property value
 */
-( nullable NSString* )setterName;
/**
 *	@brief	Encoding
 */
-( nullable NSString* )encoding;

@end
