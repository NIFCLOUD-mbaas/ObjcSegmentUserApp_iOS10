//
//  ConvertString.h
//  ObjcSegmentUserApp
//
//  Created by FUJITSU CLOUD TECHNOLOGIES on 2016/10/26.
//  Copyright 2020 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import <Foundation/Foundation.h>

@interface ConvertString : NSObject

/**
 user情報のvalueの値をNSStringクラスに変換する
 @param anyObject NSArray or NSDictionary or NSString オブジェクト
 */
+ (NSString *)convertNSStringToAnyObject:(id)anyObject;

@end
