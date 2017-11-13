//
//  NSObject+dispatch.h
//  RSUtils
//
//  Created by mhtran on 9/25/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Use dispatch_async to execute the given code block on main_queue.
 *
 *  @param block Code block to execute.
 */
extern void execOnMain( void (^block)() );
/**
 *  Use dispatch_after to execute the given code block on main_queue, delay with given time in seconds.
 *
 *  @param seconds Time (second) to delay.
 *  @param block  Code block to execute.
 */
extern void delayToMain( double seconds, void (^block)() );

@interface NSObject (dispatch)

/**
 *  Use dispatch_async to execute the given code block on main_queue.
 *
 *  @param block Code block to execute.
 */
+( void )execOnMain:( void (^)() )block;
/**
 *  Use dispatch_async to execute the given code block on main_queue.
 *
 *  @param block Code block to execute.
 */
-( void )execOnMain:( void (^)() )block;
/**
 *  Use dispatch_after to execute the given code block on main_queue, delay with given time in seconds.
 *
 *  @param seconds Time (second) to delay.
 *  @param block  Code block to execute.
 */
+( void )delayToMain:( double )seconds exec:( void (^)() )block;
/**
 *  Use dispatch_after to execute the given code block on main_queue, delay with given time in seconds.
 *
 *  @param seconds Time (second) to delay.
 *  @param block  Code block to execute.
 */
-( void )delayToMain:( double )seconds exec:( void (^)() )block;

@end
