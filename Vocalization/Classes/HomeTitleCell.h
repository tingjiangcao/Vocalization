//
//  HomeTitleCell.h
//  Vocalization
//
//  Created by caotingjiang on 2020/5/27.
//  Copyright © 2020 caotingjiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTitleCell : UITableViewCell

@property (copy ,nonatomic)  void(^addListClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
