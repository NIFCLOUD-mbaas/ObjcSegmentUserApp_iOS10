//
//  LogoutViewController.m
//  ObjcSegmentUserApp
//
//  Created by NIFTY on 2016/10/26.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

#import "LogoutViewController.h"
#import "NCMB/NCMB.h"

@interface LogoutViewController ()


@end

@implementation LogoutViewController

// Logoutボタン押下時の処理
- (IBAction)logoutBtn:(UIButton *)sender {
    [NCMBUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
     NSLog(@"ログアウトしました");
}

@end
