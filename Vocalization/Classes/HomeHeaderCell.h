//
//  HomeHeaderCell.h
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderCell : UITableViewCell <UITextViewDelegate, AVSpeechSynthesizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (strong ,nonatomic) AVSpeechSynthesizer *avSpeaker;
@property (strong ,nonatomic) AVSpeechUtterance *utterance;

@property (copy ,nonatomic) void(^showPicBlock)(NSString *content);
@property (weak, nonatomic) IBOutlet UILabel *bofangLb;
@property (weak, nonatomic) IBOutlet UILabel *tishiLb;

@end

NS_ASSUME_NONNULL_END
