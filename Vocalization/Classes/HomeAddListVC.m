//
//  HomeAddListVC.m
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import "HomeAddListVC.h"
#import "UIColor+Hex.h"

@interface HomeAddListVC ()

@end

@implementation HomeAddListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgView.layer.cornerRadius = 11;
    
    self.contentTV.font = [UIFont boldSystemFontOfSize:18];
    [self.contentTV becomeFirstResponder];
    //默认选中了音频
    [self selectType:self.yinBtn];
    
}



- (IBAction)addList:(id)sender {
    //将类型和内容，封装成字典，添加进数组，同时写进沙盒中
    if (self.contentTV.text != nil && self.selectType != nil) {
        NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
        [mDic setValue:self.contentTV.text forKey:@"content"];
        [mDic setValue:self.selectType forKey:@"selectType"];
        [self.listMArr addObject:mDic];
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [docPath stringByAppendingPathComponent:@"list.plist"];
        [self.listMArr writeToFile:filePath atomically:YES];
    }
    self.reloadBlock();
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelClick:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


//选种类型，维护变量
- (IBAction)selectType:(UIButton *)sender {
    if (sender.tag == 1000) {
        self.selectType = @"1000"; // 音频
        self.yinLb.textColor = [UIColor systemRedColor];
        self.wenLb.textColor = [UIColor systemGray3Color];
    }
    if (sender.tag == 1001) {
        self.selectType = @"1001"; // 文字
        self.wenLb.textColor = [UIColor orangeColor];
        self.yinLb.textColor = [UIColor systemGray3Color];
    }
}



@end
