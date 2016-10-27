//
//  CustomCell.h
//  ObjcSegmentUserApp
//
//  Created by NIFTY on 2016/10/26.
//  Copyright © 2016年 NIFTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (weak, nonatomic) IBOutlet UITextField *keyField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UIButton *postBtn;

- (void)setCellWithKey:(NSString *)keyStr value:(id)valueStr;
- (void)setCellWithKey:(NSString *)keyStr editValue:(id)valueStr;

@end
