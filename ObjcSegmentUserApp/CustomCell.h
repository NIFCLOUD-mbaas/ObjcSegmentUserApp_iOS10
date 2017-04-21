//
//  CustomCell.h
//  ObjcSegmentUserApp
//
//  Created by FUJITSU CLOUD TECHNOLOGIES on 2016/10/26.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (weak, nonatomic) IBOutlet UITextField *keyField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UIButton *postBtn;

/**
 通常セル (内容を表示するだけ)
 @param keyStr keyラベルに表示する文字列
 @param value valueラベルに表示するオブジェクト　（文字列、配列、Dictionary）
 */
- (void)setCellWithKey:(NSString *)keyStr value:(id)value;

/**
 value編集セル
 @param keyStr keyラベルに表示する文字列
 @param value valueラベルに表示するオブジェクト　（文字列、配列、Dictionary）
 */
- (void)setCellWithKey:(NSString *)keyStr editValue:(id)value;

@end
