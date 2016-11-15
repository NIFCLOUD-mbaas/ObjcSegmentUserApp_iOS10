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
#import "CustomCell.h"
#import "ConvertString.h"

/**
 追加fieldのマネージャー　（表示用の一時保存）
 keyの値を変更する場合があるので、追加fieldは保存ボタン時にuserに登録する
 */
@interface AddFieldManager : NSObject

@property (nonatomic) NSString *keyStr;
@property (nonatomic) NSString *valueStr;

@end

@implementation AddFieldManager
@end

@interface SegmentUserViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

// user情報を表示するリスト
@property (weak, nonatomic) IBOutlet UITableView *tableView;
// 通信結果を表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
// user情報
@property (nonatomic) NCMBUser *user;
// currentUserに登録されているkeyの配列
@property (nonatomic) NSArray *userKeys;
// user情報で初期で登録されているキー
@property (nonatomic) NSArray *initialUserKeys;
// 追加セルのマネージャー
@property (nonatomic) AddFieldManager *addFieldManager;
// textFieldの位置情報
@property (nonatomic) CGFloat textFieldPosition;

@end

@implementation SegmentUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.statusLabel.text = @"ログインに成功しました";
    
    // tableView delegate
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // user情報で初期で登録されているキーをセット
    self.initialUserKeys = @[@"objectId",@"userName",@"password",@"mailAddress",@"authData",@"sessionInfo",@"mailAddressConfirm",@"temporaryPassword",@"createDate",@"updateDate",@"acl",@"sessionToken"];
    
    // 追加セルのマネージャーの初期化
    self.addFieldManager = [[AddFieldManager alloc]init];
    
    // キーボードのイベント設定
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // user情報を取得
    [self getUser];
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
    return self.userKeys.count + 1;
}

/**
 TableViewのCellの高さを設定します。
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.userKeys.count) {
        return TABLE_VIEW_POST_BTN_CELL_HEIGHT;
    } else if ([self.userKeys[indexPath.row]isEqualToString:@"acl"]) {
        // aclセルのみ２行で表示する
        return MULTI_LINE_CELL_HEIGHT;
    }
    return TABLE_VIEW_CELL_HEIGHT;
}

/**
 TableViewのCellを返します。
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell;
    
    if (indexPath.row < self.userKeys.count) {
        // 最後のセル以外
        NSString *keyStr = self.userKeys[indexPath.row];
        id value = [self.user objectForKey:keyStr];
        
        if (![self.initialUserKeys containsObject:keyStr]) {
            // 既存フィールド以外とchannelsはvalueを編集できるようにする
            cell = [tableView dequeueReusableCellWithIdentifier:EDIT_CELL_IDENTIFIER];
            if (!cell){
                cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EDIT_CELL_IDENTIFIER];
            }
            [cell setCellWithKey:keyStr editValue:value];
            cell.valueField.delegate = self;
            cell.valueField.tag = indexPath.row;
        } else {
            // 編集なしのセル (表示のみ)
            if ([keyStr isEqualToString:@"acl"]) {
                // 表示文字数が多いセルはセルの高さを変更して全体を表示させる
                cell = [tableView dequeueReusableCellWithIdentifier:MULTI_LINE_CELL_IDENTIFIER];
                if (!cell){
                    cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MULTI_LINE_CELL_IDENTIFIER];
                }
            } else {
                // 通常のセル
                cell = [tableView dequeueReusableCellWithIdentifier:NOMAL_CELL_IDENTIFIER];
                if (!cell){
                    cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NOMAL_CELL_IDENTIFIER];
                }
            }
            [cell setCellWithKey:keyStr value:value];
        }
    } else {
        // 最後のセルは追加用セルと登録ボタンを表示
        cell = [tableView dequeueReusableCellWithIdentifier:ADD_CELL_IDENTIFIER];
        if (!cell){
            cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ADD_CELL_IDENTIFIER];
        }
        cell.keyField.delegate = self;
        cell.keyField.tag = indexPath.row;
        cell.keyField.text = self.addFieldManager.keyStr ? self.addFieldManager.keyStr : @"";
        cell.valueField.delegate = self;
        cell.valueField.tag = indexPath.row;
        cell.valueField.text = self.addFieldManager.valueStr ? self.addFieldManager.valueStr : @"";
        [cell.postBtn addTarget:self action:@selector(postUser:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

#pragma -mark requestUser

/**
 最新のuser情報を取得します。
 */
- (void)getUser {
    // NCMBUserのインスタンスを作成
    NCMBUser *user = [NCMBUser currentUser];
    
    // ユーザー情報データストアから取得
    [user fetchInBackgroundWithBlock:^(NSError *error) {
        if(!error){
            // ユーザー情報の取得が成功した場合の処理
            NSLog(@"取得に成功");
            self.user = user;
            self.userKeys = [self.user allKeys];
            // 追加fieldの値を初期化する
            self.addFieldManager.keyStr = @"";
            self.addFieldManager.valueStr = @"";
            [self.tableView reloadData];
        } else {
            // ユーザー情報の取得が失敗した場合の処理
            self.statusLabel.text = [NSString stringWithFormat:@"取得に失敗しました:%ld",(long)error.code];
        }
    }];
}

/**
 送信ボタンをタップした時に呼ばれます
 */
- (void)postUser:(id)sender {
    
    // 追加フィールドにvalueだけセットされてkeyには何もセットされていない場合
    if (![self.addFieldManager.valueStr isEqualToString:@""] && [self.addFieldManager.keyStr isEqualToString:@""]) {
        self.statusLabel.text = @"key,valueをセットで入力してください";
        return;
    }
    
    // 追加用セルの値をuserにセットする
    if (self.addFieldManager.keyStr && ![self.addFieldManager.keyStr isEqualToString:@""]) {
        // keyに値が設定されていた場合
        if ([self.addFieldManager.valueStr rangeOfString:@","].location != NSNotFound) {
            // value文字列に[,]がある場合は配列に変換してuserにセットする
            [self.user setObject:[self.addFieldManager.valueStr componentsSeparatedByString:@","] forKey:self.addFieldManager.keyStr];
        } else {
            [self.user setObject:self.addFieldManager.valueStr forKey:self.addFieldManager.keyStr];
        }
    }
    
    // user情報を更新
    [self.user saveInBackgroundWithBlock:^(NSError *error) {
        if(!error){
            self.statusLabel.text = [NSString stringWithFormat:@"更新に成功しました"];
            // tableViewの内容を更新
            [self getUser];
        } else {
            self.statusLabel.text = [NSString stringWithFormat:@"更新に失敗しました:%ld",(long)error.code];
        }
    }];
}

#pragma -mark TextFieldDelegate

/**
 キーボードの「Return」押下時の処理
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // キーボードを閉じる
    [textField resignFirstResponder];
    
    return YES;
}

/**
 textFieldの編集を開始したら呼ばれます
 textFieldの位置情報をセットします
 */
-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField {
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
    
    CGRect rectOfCellInTableView = [self.tableView rectForRowAtIndexPath:indexpath];
    CGRect rectOfCellInSuperview = [self.tableView convertRect:rectOfCellInTableView toView:[self.tableView superview]];
    // textFieldの位置情報をセット
    self.textFieldPosition = rectOfCellInSuperview.origin.y;
    
    return YES;
}

/**
 textFieldの編集が終了したら呼ばれます
 */
-(void)textFieldDidEndEditing:(UITextField*)textField {
    // tableViewのdatasorceを編集する
    if (textField.tag < self.userKeys.count) {
        // 最後のセル以外はuserを更新する
        NSString *userValueStr = [ConvertString convertNSStringToAnyObject:[self.user objectForKey:self.userKeys[textField.tag]]];
        if (![userValueStr isEqualToString:textField.text]) {
            // valueの値に変更がある場合はuserを更新する
            if ([textField.text rangeOfString:@","].location != NSNotFound) {
                // value文字列に[,]がある場合は配列に変換してuserにセットする
                [self.user setObject:[textField.text componentsSeparatedByString:@","] forKey:self.userKeys[textField.tag]];
            } else {
                // それ以外は文字列としてuserにセットする
                [self.user setObject:textField.text forKey:self.userKeys[textField.tag]];
            }
        }
    } else {
        // 追加セルはmanagerクラスを更新する（user更新時に保存する）
        CustomCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
        if ([textField isEqual:cell.keyField]) {
            // keyFieldの場合
            if (![self.addFieldManager.keyStr isEqualToString:textField.text]) {
                // keyの値に変更がある場合はマネージャーを更新する
                self.addFieldManager.keyStr = textField.text;
            }
        } else {
            // valueFieldの場合
            if (![self.addFieldManager.valueStr isEqualToString:textField.text]) {
                // valueの値に変更がある場合はマネージャーを更新する
                self.addFieldManager.valueStr = textField.text;
            }
        }
    }
}

#pragma -mark keyboardWillShow

/**
 キーボードが表示されたら呼ばれる
 */
- (void)keyboardWillShow:(NSNotification*)notification {
    
    CGRect keyboardRect = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [[self.view superview] convertRect:keyboardRect fromView:nil];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    CGFloat keyboardPosition = self.view.frame.size.height - keyboardRect.size.height;
    
    // autoLayoutを解除
    self.tableView.translatesAutoresizingMaskIntoConstraints = YES;
    
    // 編集するtextFieldの位置がキーボードより下にある場合は、位置を移動する
    if (self.textFieldPosition + TABLE_VIEW_CELL_HEIGHT > keyboardPosition) {
        // アニメーションでtextFieldを動かす
        [UIView animateWithDuration:[duration doubleValue]
                         animations:^{
                             CGRect rect = self.tableView.frame;
                             rect.origin.y = keyboardRect.origin.y - self.textFieldPosition;
                             self.tableView.frame = rect;
                         } ];
    }
}

/**
 キーボードが隠れると呼ばれる
 */
- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    // アニメーションでtextFieldを動かす
    [UIView animateWithDuration:[duration doubleValue]
                     animations:^{
                         CGRect rect = self.tableView.frame;
                         rect.origin.y = self.view.frame.size.height - self.tableView.frame.size.height;
                         self.tableView.frame = rect;
                     }];
}

// 背景をタップするとキーボードを隠す
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    [self.view endEditing: YES];
}

// Logoutボタン押下時の処理
- (IBAction)logoutBtn:(UIButton *)sender {
    [NCMBUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"ログアウトしました");
}

@end
