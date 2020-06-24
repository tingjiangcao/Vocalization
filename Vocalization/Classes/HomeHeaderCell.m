//
//  HomeHeaderCell.m
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import "HomeHeaderCell.h"

@implementation HomeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 11;
    
    
    //初始化语音合成器
    self.avSpeaker = [[AVSpeechSynthesizer alloc] init];
    self.avSpeaker.delegate = self;
    
    self.contentTV.font = [UIFont boldSystemFontOfSize:18];
    self.contentTV.delegate = self;
    
    //取出上次写的东西，假如有的话就隐藏tishilb
    NSString *last = [[NSUserDefaults standardUserDefaults] objectForKey:@"last"];
    if (last != nil && ![last isEqualToString:@""]) {
        self.contentTV.text = last;
        self.tishiLb.hidden = YES;
    }
}




// 清除按钮
- (IBAction)clearContentTV:(id)sender {
        self.contentTV.text = nil;
    [self.contentTV becomeFirstResponder];
}


// 播放语音
- (IBAction)playVoice:(id)sender {
    
    //话语
    self.utterance = [[AVSpeechUtterance alloc] initWithString:self.contentTV.text];//话语内容
    self.utterance.rate = 0.50; //语速
    self.utterance.pitchMultiplier = 1.0; //音高
    self.utterance.volume = 1; //音量
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    self.utterance.voice = voice; //普通话

    //用语音合成器 说 配置好的话语
    [self.avSpeaker speakUtterance:self.utterance];
    
}

// 创建文字
- (IBAction)shhowPic:(id)sender {
    self.showPicBlock(self.contentTV.text);
}


// 开始播放语音
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.bofangLb.text = @"正在播放";
    self.bofangLb.textColor = [UIColor redColor];
    self.contentTV.textColor = [UIColor redColor];
}

// 语音播放完毕
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.bofangLb.text = @"点击播放";
    self.bofangLb.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.contentTV.textColor = [UIColor blackColor];
}

//隐藏提示文字：textView内容为空，且不在编辑状态
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.tishiLb.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        self.tishiLb.hidden = NO;
    } else {
        self.tishiLb.hidden = YES;
    }
    //存下上次写的东西
    [[NSUserDefaults standardUserDefaults] setObject:self.contentTV.text forKey:@"last"];
}

@end
