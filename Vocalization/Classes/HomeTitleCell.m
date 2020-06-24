//
//  HomeTitleCell.m
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import "HomeTitleCell.h"

@implementation HomeTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


// 添加快捷用语
- (IBAction)addList:(id)sender {
    self.addListClickBlock();
}


@end
