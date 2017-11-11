//
//  NSString+language.h
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef NS_ENUM( NSUInteger, UniCharType ){
    kUCTypeOther = 0,
    kUCTypeGeneralSymbol,
    kUCTypeLatinAlphaUp,
    kUCTypeLatinAlphaLow,
    kUCTypeLatinDigit,
    kUCTypeLatinSymbol,
    kUCTypeJPHiragana,
    kUCTypeJPKatakana,
    kUCTypeJPSymbol,
    kUCTypeJPRomanjiSymbol,
    kUCTypeJPRomanjiDigit,
    kUCTypeJPRomanjiAlphaUp,
    kUCTypeJPRomanjiAlphaLow,
    kUCTypeJPKatakanaHalfWidth,
    kUCTypeCJKCommon, // kanji
    kUCTypeCJKRare
};

@interface NSString (language)

+( UniCharType )typeOfUnicodeCharacter:( UniChar )uChar;

-( BOOL )isContainingJapaneseCharacter;
-( BOOL )isEnglishText;

@end
