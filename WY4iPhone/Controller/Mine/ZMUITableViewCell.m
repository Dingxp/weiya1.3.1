//
//  ZMUITableViewCell.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/19.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMUITableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ZMUITableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setChannelItem:(ZMChannelItem *)channelItem
{
    _channelItem=channelItem;
    [self initWith];
    
}
-(void)initWith
{
    _decImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    [self.contentView addSubview:_decImage];
   _nameLab=[[UILabel alloc]initWithFrame:CGRectMake(_decImage.right+10, 5, APP_SCREEN_WIDTH-_decImage.right-10, 60)];
    _nameLab.font = [UIFont systemFontOfSize:15];
    _nameLab.numberOfLines =0;
    
    [self.contentView addSubview:_nameLab];
    
    _countPriceLab=[[UILabel alloc]initWithFrame:CGRectMake(_decImage.right+10, 70, 120,40 )];
    
    [self.contentView addSubview:_countPriceLab];
    [_decImage sd_setImageWithURL:[NSURL URLWithString:_channelItem.httpImgUrl]];
  
    _nameLab.text=_channelItem.proName;
    _countPriceLab.attributedText = [self parserString:@"销售：" withContentStr:[NSString stringWithFormat:@"￥%@",_channelItem.currentPrice]];

}
/**
 *  富文本，拼接字符串
 *
 *  @param preStr 待拼接的字符串1
 *  @param str    待拼接的字符串2
 *
 *  @return 拼接好的字符串
 */
- (NSMutableAttributedString *) parserString:(NSString *)preStr withContentStr:(NSString *)str{
    NSString *postStr = [NSString stringWithFormat:@"%@%@", preStr, str];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:postStr];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(115, 115, 115)
                       range:NSMakeRange(0, preStr.length)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(238, 68, 100)
                       range:NSMakeRange(preStr.length, str.length)];
    UIFont *preFont = [UIFont systemFontOfSize:12];
    [attrString addAttribute:NSFontAttributeName value:preFont range:NSMakeRange(0, preStr.length)];
    
    UIFont *font = [UIFont systemFontOfSize:17];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(preStr.length, str.length)];
    
    //    cell.textLabel.attributedText = attrString;
    return attrString;
}

@end
