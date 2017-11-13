//
//  NSObject+dispatch.m
//  RSUtils
//
//  Created by mhtran on 9/25/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

#import "NSObject+dispatch.h"

void execOnMain( void (^block)() ){
    dispatch_async( dispatch_get_main_queue(), block );
}

void delayToMain( double seconds, void (^block)() ){
    dispatch_after( dispatch_time( DISPATCH_TIME_NOW, ( int64_t )( seconds * NSEC_PER_SEC )), dispatch_get_main_queue(), block );
}

@implementation NSObject (dispatch)

+( void )execOnMain:( void (^)() )block; {
    execOnMain( block );
}

-( void )execOnMain:( void (^)() )block; {
    execOnMain( block );
}

+( void )delayToMain:( double )seconds exec:( void (^)() )block {
    delayToMain( seconds, block );
}

-( void )delayToMain:( double )seconds exec:( void (^)() )block {
    delayToMain( seconds, block );
}

@end
