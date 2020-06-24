//
//  HomeAddListVC.h
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeAddListVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (strong ,nonatomic) NSMutableArray *listMArr;
@property (copy ,nonatomic) void(^reloadBlock)(void);

@property (weak, nonatomic) IBOutlet UIButton *yinBtn;
@property (weak, nonatomic) IBOutlet UIButton *wenBtn;
@property (weak, nonatomic) IBOutlet UILabel *yinLb;
@property (weak, nonatomic) IBOutlet UILabel *wenLb;

@property (copy ,nonatomic) NSString *selectType;

@end

NS_ASSUME_NONNULL_END
