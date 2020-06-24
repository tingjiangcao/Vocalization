//
//  AppDelegate.m
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "BaseNvc.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    CGSize scsize =  [UIScreen mainScreen].bounds.size;
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, scsize.width, scsize.height)];
    HomeVC *homeVC = [HomeVC new];
    BaseNvc *homeNvc = [[BaseNvc alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = homeNvc;
    [self.window makeKeyAndVisible];
    
    
    
    //进app时，检查是否有 list.plist 文件，如果没有就创建一个，形式为数组包着字典。
    //    if ([NSArray arrayWithContentsOfFile:filePath] == nil) {
    //        NSMutableArray *listMArr = [[NSMutableArray alloc] init];
    //        [listMArr writeToFile:filePath atomically:YES];
    //    }
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"list.plist"];
    NSString *first = [[NSUserDefaults standardUserDefaults] objectForKey:@"First"];
    if (![first isEqualToString:@"diyici"]) { // 不是第一次启动
        [[NSUserDefaults standardUserDefaults] setObject:@"diyici" forKey:@"First"];
        
        // 1. 创建Plist，同时初始化一些值
        NSMutableArray *listMArr = [[NSMutableArray alloc] init];
        NSMutableDictionary *mDic1 = [NSMutableDictionary dictionary];
        
        [mDic1 setObject:@"请问厕所在哪里，谢谢。" forKey:@"content"];
        [mDic1 setObject:@"1000" forKey:@"selectType"];
        [listMArr addObject:mDic1];
        
        NSMutableDictionary *mDic2 = [NSMutableDictionary dictionary];
        [mDic2 setObject:@"请问我可以出去一趟吗？" forKey:@"content"];
        [mDic2 setObject:@"1001" forKey:@"selectType"];
        [listMArr addObject:mDic2];
        
        NSMutableDictionary *mDic3 = [NSMutableDictionary dictionary];
        [mDic3 setObject:@"请问二维码在哪里？" forKey:@"content"];
        [mDic3 setObject:@"1000" forKey:@"selectType"];
        [listMArr addObject:mDic3];
        
        NSMutableDictionary *mDic4 = [NSMutableDictionary dictionary];
        [mDic4 setObject:@"我有些不舒服需要休息一下。" forKey:@"content"];
        [mDic4 setObject:@"1001" forKey:@"selectType"];
        [listMArr addObject:mDic4];
        
        NSMutableDictionary *mDic5 = [NSMutableDictionary dictionary];
        [mDic5 setObject:@"师傅，麻烦打个发票好去报销。" forKey:@"content"];
        [mDic5 setObject:@"1000" forKey:@"selectType"];
        [listMArr addObject:mDic5];
        
        [listMArr writeToFile:filePath atomically:YES];
        
        // 2. 设置备忘录的初始信息
        [[NSUserDefaults standardUserDefaults] setObject:
         @"这是我的个人信息\n"\
         "姓名：张峰\n"\
         "家庭住址：灌云县南岗乡\n"\
         "身份证号：320723199705204032\n"\
         "\n联系方式：\n父：1535939393\n"\
         "母：1345849959\n"\
         "\n医疗情况：\n需按时注射胰岛素。" forKey:@"riji"];
    }
    
    
    return YES;
}



@end
