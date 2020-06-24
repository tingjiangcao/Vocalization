//
//  HomeListCell.m
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import "HomeListCell.h"

@implementation HomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLb.text = titleStr;
}

- (void)setSelectType:(NSString *)selectType {
    _selectType = selectType;
    if ([selectType isEqualToString:@"1000"]) {
        [self.typeBtn setImage:[UIImage imageNamed:@"home_list1"] forState:UIControlStateNormal];
    }else if ([selectType isEqualToString:@"1001"]) {
        [self.typeBtn setImage:[UIImage imageNamed:@"home_list4"] forState:UIControlStateNormal];
    }else {
        [self.typeBtn setImage:nil forState:normal];
    }
}

- (IBAction)playClick:(id)sender {
    // 不同类型走不同回调
    if ([self.selectType isEqualToString:@"1000"]) {
        self.playClickBlock(self.titleStr);
    } else if ([self.selectType isEqualToString:@"1001"]) {
        self.showClickBlock(self.titleStr);
    }
}


@end
