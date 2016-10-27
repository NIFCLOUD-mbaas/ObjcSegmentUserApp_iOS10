//
//  CustomCell.m
//  ObjcSegmentUserApp
//
//  Created by NIFTY on 2016/10/26.
//  Copyright © 2016年 NIFTY. All rights reserved.
//

#import "CustomCell.h"
#import <NCMB/NCMB.h>
#import "AppSetting.h"

#import "ConvertString.h"

@interface CustomCell()

@end

@implementation CustomCell

/**
 通常セル (内容を表示するだけ)
 @param keyStr keyラベルに表示する文字列
 @param valueStr valueラベルに表示する文字列
 */
- (void)setCellWithKey:(NSString *)keyStr value:(id)valueStr {

    self.keyLabel.text = keyStr;

    if (valueStr) {
        self.valueLabel.text = [ConvertString convertNSStringToAnyObject:valueStr];
    }
}

/**
 value編集セル
 @param keyStr keyラベルに表示する文字列
 @param valueStr valueテキストフィールドに表示する文字列
 */
- (void)setCellWithKey:(NSString *)keyStr editValue:(id)valueStr {

    self.keyLabel.text = keyStr;

    if (valueStr) {
        self.valueField.text = [ConvertString convertNSStringToAnyObject:valueStr];

    }

}

@end
