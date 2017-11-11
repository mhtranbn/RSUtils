//
//  NSFileManager+appFolder.h
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
#import <Foundation/Foundation.h>

/**
 *  Follow iOS 8 requirement for app folder path
 */
@interface NSFileManager (appFolder)

-( nullable NSString* )documentPath;
-( nullable NSString* )librayPath;
-( nullable NSString* )cachesPath;

-( BOOL )copyItemAtPath:( nonnull NSString* )srcPath
          overwritePath:( nonnull NSString* )dstPath
                  error:(  NSError* _Nullable* _Nullable )error;
-( BOOL )moveItemAtPath:( nonnull NSString* )srcPath
          overwritePath:( nonnull NSString* )dstPath
                  error:(  NSError* _Nullable* _Nullable )error;
-( BOOL )copyItemAtURL:( nonnull NSURL* )srcURL
          overwriteURL:( nonnull NSURL* )dstURL
                 error:(  NSError* _Nullable* _Nullable )error;
-( BOOL )moveItemAtURL:( nonnull NSURL* )srcURL
          overwriteURL:( nonnull NSURL* )dstURL
                 error:(  NSError* _Nullable* _Nullable )error;


@end
