//
//  CustomCell.m
//  ObjcSegmentUserApp
//
//  Created by FUJITSU CLOUD TECHNOLOGIES on 2016/10/26.
//  Copyright 2020 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
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
 @param value valueラベルに表示するオブジェクト　（文字列、配列、Dictionary）
 */
- (void)setCellWithKey:(NSString *)keyStr value:(id)value {

    self.keyLabel.text = keyStr;
    
    if (value && ![value isEqual:[NSNull null]] && [keyStr isEqualToString:@"mailAddressConfirm"]) {
        // mailAddressConfirmは真偽値を文字列に変換
        self.valueLabel.text = value && [value boolValue] ? @"true" : @"false";
    } else {
        self.valueLabel.text = value ? [ConvertString convertNSStringToAnyObject:value] : @"";
    }
}

/**
 value編集セル
 @param keyStr keyラベルに表示する文字列
 @param value valueラベルに表示するオブジェクト　（文字列、配列、Dictionary）
 */
- (void)setCellWithKey:(NSString *)keyStr editValue:(id)value {

    self.keyLabel.text = keyStr;
    
    self.valueField.text = value ? [ConvertString convertNSStringToAnyObject:value] : @"";
}

@end
