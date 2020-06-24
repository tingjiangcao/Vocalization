//
//  HomeRijiCell.h
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeRijiCell : UITableViewCell <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextView *contentLb;


@end

NS_ASSUME_NONNULL_END
