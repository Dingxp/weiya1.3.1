//
//  CouponListTableViewCell.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/14.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "CouponListTableViewCell.h"

@implementation CouponListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)initView
{
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    UIImageView*backImage=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, APP_SCREEN_WIDTH-10, 110)];
    backImage.image=[UIImage imageNamed:@"ticket"];
    [self addSubview:backImage];
    //优惠劵价格
    _couponAmount=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, 100, 60)];
    _couponAmount.font=[UIFont systemFontOfSize:22];
    _couponAmount.textColor=[UIColor redColor];
    _couponAmount.text=[NSString stringWithFormat:@"￥%@",_couponList.couponAmount];
    [self addSubview:_couponAmount];
    //使用与过期
    _isUsedImage=[[UIImageView alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH/2-60, 35, 50, 50)];
    _isUsedImage.image=[UIImage imageNamed:@"useing"];
    [self addSubview:_isUsedImage];
    UIView*line=[[UIView alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH/2, 15, 1,90)];
    line.backgroundColor=[UIColor redColor];
    [self addSubview:line];
    //名字
    _couponName=[[UILabel alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH/2+4, 10, APP_SCREEN_WIDTH/2-10-4, 40)];
    _couponName.text=_couponList.desc;
    _couponName.numberOfLines=2;
    _couponName.textColor=[UIColor redColor];
    _couponName.font=[UIFont systemFontOfSize:13];
    _couponName.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_couponName];
    
    _lab=[[UILabel alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH/2+4, _couponName.bottom+10, APP_SCREEN_WIDTH/2-10-4, 15)];
    _lab.text=@"APP在线支付时使用";
    _lab.textColor=[UIColor redColor];
    _lab.font=[UIFont systemFontOfSize:13];
    _lab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_lab];
    //还有几天过期
    _remainderTimeLab=[[UILabel alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH/2+4, _lab.bottom+10, APP_SCREEN_WIDTH/2-10-4, 15)];
    _remainderTimeLab.text=_couponList.remainderTime;;
    _remainderTimeLab.textColor=[UIColor redColor];
    _remainderTimeLab.font=[UIFont systemFontOfSize:13];
    _remainderTimeLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_remainderTimeLab];
    //判断是否过期
    if ([_couponList.expireState isEqualToString:@"1"])
    {    _isUsedImage.image=[UIImage imageNamed:@"isState"];
        _couponAmount.textColor=[UIColor grayColor];
        line.backgroundColor=[UIColor grayColor];
        _couponName.textColor=[UIColor grayColor];
        _lab.textColor=[UIColor grayColor];
        _remainderTimeLab.textColor=[UIColor grayColor];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCouponList:(ZMCouponList *)couponList
{
    _couponList=couponList;
    [self initView];
}
@end
