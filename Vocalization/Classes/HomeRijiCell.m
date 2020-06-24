//
//  HomeRijiCell.m
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import "HomeRijiCell.h"

@implementation HomeRijiCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.bgView.layer.cornerRadius = 11;
    self.contentLb.font = [UIFont boldSystemFontOfSize:17];
    self.contentLb.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"riji"];
    self.contentLb.delegate = self;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    [[NSUserDefaults standardUserDefaults] setObject:textView.text forKey:@"riji"];
}

    
@end
