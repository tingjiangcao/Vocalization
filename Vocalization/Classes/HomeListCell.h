//
//  HomeListCell.h
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeListCell : UITableViewCell

@property (copy ,nonatomic) NSString *titleStr;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (copy ,nonatomic) void(^playClickBlock)(NSString *content);
@property (copy ,nonatomic) void(^showClickBlock)(NSString *content);
@property (copy ,nonatomic) NSString *selectType;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;

@end

NS_ASSUME_NONNULL_END
