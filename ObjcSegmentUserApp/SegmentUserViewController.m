//
//  SegmentUserViewController.m
//  ObjcSegmentUserApp
//
//  Created by NIFTY on 2016/10/26.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

#import "SegmentUserViewController.h"
#import "NCMB/NCMB.h"

#import "AppSetting.h"

/**
 追加fieldのマネージャー　（表示用の一時保存）
 keyの値を変更する場合があるので、追加fieldは保存ボタン時にinstallationに登録する
 */
@interface AddFieldManager : NSObject

@property (nonatomic) NSString *keyStr;
@property (nonatomic) NSString *valueStr;

@end

@implementation AddFieldManager
@end

@interface SegmentUserViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

// installationの内容を表示するリスト
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SegmentUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // TableView
    UINib *nib = [UINib nibWithNibName:@"Main" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"aaaa"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

#pragma -mark TableViewDataSource

/**
 TableViewのheaderViewを返します。
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return (UIView *)[tableView dequeueReusableCellWithIdentifier:@"sectionHeader"];
}

/**
 TableViewのCellの数を設定します。
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;//self.instKeys.count + 1;
}

///**
// TableViewのCellの高さを設定します。
// */
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (indexPath.row == 2) {
//        return TABLE_VIEW_POST_BTN_CELL_HEIGHT;
//    }
////    else if ([self.instKeys[indexPath.row]isEqualToString:@"deviceToken"]) {
////        return DEVICE_TOKEN_CELL_HEIGHT;
////    }
//    
//    return TABLE_VIEW_CELL_HEIGHT;
//}

/**
 TableViewのCellを返します。
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NOMAL_CELL_IDENTIFIER];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NOMAL_CELL_IDENTIFIER];
    }
    
//    CustomCell *cell;
//
//    if (indexPath.row < self.instKeys.count) {
//        // 最後のセル以外
//        NSString *keyStr = self.instKeys[indexPath.row];
//        NSString *valueStr = [self.installation objectForKey:self.instKeys[indexPath.row]];
//        
//        if (![self.initialInstKeys containsObject:keyStr]) {
//            // 既存フィールド以外とchannelsはvalueを編集できるようにする
//            cell = [tableView dequeueReusableCellWithIdentifier:EDIT_CELL_IDENTIFIER];
//            if (!cell){
//                cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EDIT_CELL_IDENTIFIER];
//            }
//            [cell setCellWithKey:keyStr editValue:valueStr];
//            cell.valueField.delegate = self;
//            cell.valueField.tag = indexPath.row;
//        } else {
//            // 編集なしのセル (表示のみ)
//            if ([keyStr isEqualToString:@"deviceToken"]) {
//                // deviceTokenセルはセルの高さを変更して全体を表示させる
//                cell = [tableView dequeueReusableCellWithIdentifier:TOKEN_CELL_IDENTIFIER];
//                if (!cell){
//                    cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TOKEN_CELL_IDENTIFIER];
//                }
//            } else {
//                // deviceTokenセル以外
//                cell = [tableView dequeueReusableCellWithIdentifier:NOMAL_CELL_IDENTIFIER];
//                if (!cell){
//                    cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NOMAL_CELL_IDENTIFIER];
//                }
//            }
//            [cell setCellWithKey:keyStr value:valueStr];
//        }
//    } else {
//        // 最後のセルは追加用セルと登録ボタンを表示
//        cell = [tableView dequeueReusableCellWithIdentifier:ADD_CELL_IDENTIFIER];
//        if (!cell){
//            cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ADD_CELL_IDENTIFIER];
//        }
//        [cell setAddRecordCell];
//        cell.keyField.delegate = self;
//        cell.keyField.tag = indexPath.row;
//        cell.keyField.text = self.addFieldManager.keyStr ? self.addFieldManager.keyStr : @"";
//        cell.valueField.delegate = self;
//        cell.valueField.tag = indexPath.row;
//        cell.valueField.text = self.addFieldManager.valueStr ? self.addFieldManager.valueStr : @"";
//        [cell.postBtn addTarget:self action:@selector(postInstallation:) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    return cell;
}

// Logoutボタン押下時の処理
- (IBAction)logoutBtn:(UIButton *)sender {
    [NCMBUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
     NSLog(@"ログアウトしました");
}

@end
