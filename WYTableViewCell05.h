//
//  WYTableViewCell05.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/20.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WYTableViewCell05Delegate <NSObject>

@optional
- (void) themeDelegateClickedAtIndex:(long) index;

@end
@interface WYTableViewCell05 : UITableViewCell

@property (strong,nonatomic)UIImageView*imgView01;
@property (strong,nonatomic)UIImageView*firstImage;
@property (strong,nonatomic)NSArray*detailArray;
@property (nonatomic, assign) id <WYTableViewCell05Delegate> delegate;
@end
