//
//  HomeVC.m
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import "HomeVC.h"
#import "UIColor+Hex.h"
#import <Masonry.h>

#import "HomeHeaderCell.h"
#import "HomeTitleCell.h"
#import "HomeListCell.h"
#import "HomeRijiCell.h"

#import "HomeAddListVC.h"

@interface HomeVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong ,nonatomic) UITableView *tableView;
@property (strong ,nonatomic) NSMutableArray *listMArr;

@property (strong ,nonatomic) AVSpeechSynthesizer *avSpeaker;
@property (strong ,nonatomic) AVSpeechUtterance *utterance;

@property (strong ,nonatomic) UIButton *maskBtn;
@property (strong ,nonatomic) UIView *contentView;
@property (strong ,nonatomic) UILabel *contentlb;
@property (strong ,nonatomic) UIImageView *leftV;
@property (strong ,nonatomic) UIImageView *rightV;

@end



@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    //创建主tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0); //insetgroup的特性是自带inse和组头
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor =  [UIColor colorWithHexString:@"#F5F5F5"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHeaderCell" bundle:nil] forCellReuseIdentifier:@"headerCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTitleCell" bundle:nil] forCellReuseIdentifier:@"titleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeListCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeRijiCell" bundle:nil] forCellReuseIdentifier:@"rijiCell"];
    
    
    //读取本地沙盒 list.plist 为一个数组
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"list.plist"];
    self.listMArr = [NSMutableArray arrayWithContentsOfFile:filePath];
    //NSLog(@"%@😄", NSHomeDirectory());
    
    //初始化语音合成器
    self.avSpeaker = [[AVSpeechSynthesizer alloc] init];
    //self.avSpeaker.delegate = self;
    
    //遮罩btn
    CGSize ssize = [UIScreen mainScreen].bounds.size;
    self.maskBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ssize.width, ssize.height)];
    [self.view addSubview:self.maskBtn];
    self.maskBtn.backgroundColor = [UIColor blackColor];
    self.maskBtn.alpha = 0;
    [self.maskBtn addTarget:self action:@selector(hideMaskBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.contentView];
    self.contentView.layer.cornerRadius = 11;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view).offset(-100);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(188);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    self.contentView.alpha = 0;
    
    //文字label
    self.contentlb = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.contentlb];
    [self.contentlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(120);
    }];
    self.contentlb.font = [UIFont boldSystemFontOfSize:30];
    self.contentlb.alpha = 0.0;
    self.contentlb.numberOfLines = 0;
    
    //两个引号
    self.leftV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_headershang"]];
    self.rightV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_headerxia"]];
    [self.contentView addSubview:self.leftV];
    [self.contentView addSubview:self.rightV];
    [self.leftV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(50);
    }];
    [self.rightV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(50);
    }];
    self.leftV.alpha = 0.0;
    self.rightV.alpha = 0.0;
    
}

- (void)hideMaskBtn {
    [UIView animateWithDuration:0.5 animations:^{
        self.maskBtn.alpha = 0.0;
    }];
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.alpha = 0.0;
    }];;
}

#pragma mark-- tableView 的 datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    
    if (section == 1) {
        return self.listMArr.count;
    }
    
    if (section == 2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                HomeHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell" forIndexPath:indexPath];
                headerCell.showPicBlock = ^(NSString * _Nonnull content) { //遮罩与文字 出现
                    self.contentlb.text = content;
                    [UIView animateWithDuration:0.2 animations:^{
                        self.maskBtn.alpha = 0.8;
                        self.contentView.alpha = 1.0;
                        self.contentlb.alpha = 1.0;
                        self.leftV.alpha = 1.0;
                        self.rightV.alpha = 1.0;
                    }];
                    
                };
                return headerCell;
            }
                
            case 1:
            {
                HomeTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
                titleCell.addListClickBlock = ^{ //添加list的回调
                    HomeAddListVC *addListVC = [HomeAddListVC new];
                    addListVC.listMArr = self.listMArr;
                    addListVC.reloadBlock = ^{
                        [self.tableView reloadData];
                    };
                    [self presentViewController:addListVC animated:YES completion:nil];
                };
                return titleCell;
            }
            default:
                break;
        }
    }
    
    if (indexPath.section == 1) {
        HomeListCell *listCell =  [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
        listCell.titleStr = [self.listMArr[indexPath.row] objectForKey:@"content"]; //加载本地的title，给到cell
        listCell.selectType = [self.listMArr[indexPath.row] objectForKey:@"selectType"]; //加载类型传给cell
        listCell.playClickBlock = ^(NSString * _Nonnull content) { //点击cell播放音频
            //话语
            self.utterance = [[AVSpeechUtterance alloc] initWithString:content];//话语内容
            self.utterance.rate = 0.50; //语速
            self.utterance.pitchMultiplier = 1.0; //音高
            self.utterance.volume = 1; //音量
            AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
            self.utterance.voice = voice; //普通话
            
            //用语音合成器 说 配置好的话语
            [self.avSpeaker speakUtterance:self.utterance];
        };
        listCell.showClickBlock = ^(NSString * _Nonnull content) {
            self.contentlb.text = content;
            [UIView animateWithDuration:0.1 animations:^{
                self.maskBtn.alpha = 0.8;
            }];
            [UIView animateWithDuration:0.3 animations:^{
                self.contentView.alpha = 1.0;
                self.contentlb.alpha = 1.0;
                self.leftV.alpha = 1.0;
                self.rightV.alpha = 1.0;
            }];
        };
        return listCell;
    }
    
    if (indexPath.section == 2) {
        HomeRijiCell *rijiCell =  [tableView dequeueReusableCellWithIdentifier:@"rijiCell" forIndexPath:indexPath];
        return rijiCell;
    }
    
    return nil;
}



#pragma mark-- tableView 的 delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 200;
        } else {
            return 50;
        }
    }
    
    if (indexPath.section == 1) {
        return 50;
    }
    
    if (indexPath.section == 2) {
        return 420;
    }
    
    return 0;
}


//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return YES;
    }
        return NO;
}

// 删除指定行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.删除数组中指定元素 2.写入沙盒 3.刷新控件（无需重新加载数据）
    [self.listMArr removeObjectAtIndex:indexPath.row];
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"list.plist"];
    [self.listMArr writeToFile:filePath atomically:YES];
    // [self.tableView reloadData];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
}


#pragma mark-- 解决间距,insetgroup的特性问题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

@end
