//
//  NSKeyedUnarchiverWrapper.m
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
#import "NSKeyedUnarchiverWrapper.h"

NSObject * __nullable _awesomeCache_unarchiveObjectSafely(NSString *path) {
    @try {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    @catch (NSException *exception) {
        NSLog(@"Caught exception while unarchiving file at path %@: %@", path, exception);
        return nil;
    }
}
