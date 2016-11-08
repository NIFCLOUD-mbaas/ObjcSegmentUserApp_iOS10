//
//  ConvertString.h
//  ObjcSegmentUserApp
//
//  Created by NIFTY on 2016/10/26.
//  Copyright © 2016年 NIFTY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConvertString : NSObject

/**
 user情報のvalueの値をNSStringクラスに変換する
 @param anyObject NSArray or NSDictionary or NSString オブジェクト
 */
+ (NSString *)convertNSStringToAnyObject:(id)anyObject;

@end
