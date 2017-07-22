//
//  ZMProDetailTableView.m
//  WY4iPhone
//
//  Created by ZM on 15/9/23.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMProDetailTableView.h"
#import "ZMProDetailTableViewCell.h"
#import "ZMProductDetail.h"
#import "ZMProDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ADFocusImageView.h"

@interface ZMProDetailTableView (){
    UIView *footerView;
    UIView *viewTop;
    UIImageView *imgHead;
    UILabel *labelProductName;
    UILabel *labelPrice;
    UILabel *labelOldPrice;
    UILabel *labelCommission;
    UILabel *labelRecommendReason;
    NSMutableArray*calculateArray;
    //打折
    UILabel*discountLab;
    
    //    CGFloat cellHeight;
    NSInteger imageHight;
    NSInteger imageWidth;
    NSMutableArray *cellHeightArry;
    NSInteger arryIndex;
}

@end

@implementation ZMProDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if ( self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        _headViewHeight = 0;
        arryIndex = 0;
        cellHeightArry = [NSMutableArray array];
        [self initHeadView];
        [self initFooterView];
        //        [self loadData];
    }
    return self;
}

/**
 *  初始化头部View
 */
- (void) initHeadView{
    
    // 顶部view
    viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_WIDTH+110)];
    viewTop.backgroundColor = [UIColor whiteColor];
    //    self.tableHeaderView = viewTop;
    
    imgHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, viewTop.width, 180)];
    imgHead.contentMode = UIViewContentModeScaleAspectFit;
    _loopingView = [[ZMShopScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_WIDTH)];
    [viewTop addSubview:_loopingView];
    
    labelProductName = [[UILabel alloc] initWithFrame:CGRectMake(10, _loopingView.bottom + 10, viewTop.width - 20, 35)];
    //    labelProductName.backgroundColor = [UIColor yellowColor ];
    labelProductName.font = [UIFont systemFontOfSize:15];
    labelProductName.numberOfLines = 0;
    labelProductName.textColor = [UIColor blackColor];
    [viewTop addSubview:labelProductName];
    
    labelRecommendReason = [[UILabel alloc] initWithFrame:CGRectMake(labelProductName.left, labelProductName.bottom + 10, labelProductName.width, 0)];
    labelRecommendReason.font = [UIFont systemFontOfSize: 14];
    labelRecommendReason.textColor = RGBCOLOR(177, 177, 177);
    labelRecommendReason.numberOfLines = 0;
    [viewTop addSubview:labelRecommendReason];
    
    labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(labelProductName.left, labelRecommendReason.bottom + 10, 68, 17)];
    labelPrice.font = [UIFont systemFontOfSize: 17];
    labelPrice.textColor = RGBCOLOR(255, 0, 96);
    [viewTop addSubview:labelPrice];
    
    labelOldPrice = [[UILabel alloc] initWithFrame:CGRectMake(labelPrice.right,labelPrice.bottom - 14, 70, 12)];
    labelOldPrice.font = [UIFont systemFontOfSize: 12];
    labelOldPrice.textColor = RGBCOLOR(159, 159, 159);
    [viewTop addSubview:labelOldPrice];
    discountLab = [[UILabel alloc] initWithFrame:CGRectMake(labelOldPrice.right,labelPrice.bottom-20, 40, 20)];
    discountLab.font = [UIFont systemFontOfSize: 12];
    discountLab.textColor = RGBCOLOR(255, 0, 96);
    //discountLab.textColor=[UIColor redColor];
    discountLab.layer.borderColor = [UIColor redColor].CGColor;
    discountLab.layer.borderWidth = 1;
    discountLab.textAlignment = NSTextAlignmentCenter;
    [viewTop addSubview:discountLab];
    
    labelCommission = [[UILabel alloc] initWithFrame:CGRectMake(viewTop.width - 100 - 10, labelPrice.bottom - 17, 100, 17)];
    labelCommission.font = [UIFont systemFontOfSize: 17];
    labelCommission.textColor = RGBCOLOR(255, 0, 96);
    labelCommission.textAlignment = NSTextAlignmentRight;
    [viewTop addSubview:labelCommission];
    //分享 收藏
    _collectView = [[UIView alloc]initWithFrame:CGRectMake(0, viewTop.bottom-65, APP_SCREEN_WIDTH/2 -1, 55)];
    [viewTop addSubview:_collectView];
    _shareView= [[UIView alloc]initWithFrame:CGRectMake(_collectView.right+2, _collectView.bottom-55, APP_SCREEN_WIDTH/2, 55)];
    //_shareView.backgroundColor=[UIColor redColor];
    
    [viewTop addSubview:_shareView];
     _line = [[UIView alloc] initWithFrame:CGRectMake(0, viewTop.bottom - 10, viewTop.width, 10)];
    _line.backgroundColor = RGBCOLOR(240, 240, 240);
    [viewTop addSubview:_line];
    
    //    self.tableHeaderView = viewTop;
    
}

- (void)setProDetail:(ZMProductDetail *)proDetail
{
    _proDetail = proDetail;
    [self loadData];
    [self initProDetailImages];
    
    
}

- (void) loadData{
    _loopingView.imageArry=_proDetail.titleList;
    NSLog(@"==%@",_proDetail);
    
    if ([_proDetail.isBW isEqualToString:@"0"])
    {
        labelProductName.text = _proDetail.proName;
    }
    else
    {
        labelProductName.text=[NSString stringWithFormat:@"[ 保税仓 ]%@",_proDetail.proName];
    }
    
    
    
    CGRect proNameFrame = labelProductName.frame;
    proNameFrame.size.height = [_proDetail.proName commonStringHeighforLabelWidth:viewTop.width - 20 withFontSize:15];
    labelProductName.frame = proNameFrame;
    
    if (_proDetail.desc == NULL || [_proDetail.desc isEmpty]) {
        labelRecommendReason.hidden = YES;
        labelPrice.frame = CGRectMake(labelPrice.left, labelProductName.bottom + 10, labelPrice.width, labelPrice.height);
        _headViewHeight = _loopingView.height + labelProductName.height + labelPrice.height + 40 + 10;
        viewTop.frame = CGRectMake(viewTop.left, viewTop.top, viewTop.width, _headViewHeight+60);
    } else {
        labelRecommendReason.text = _proDetail.desc;
        CGRect reasonFrame = labelRecommendReason.frame;
        reasonFrame.size.height = [_proDetail.desc commonStringHeighforLabelWidth:viewTop.width - 20 withFontSize:14];
        reasonFrame.origin.y = labelProductName.bottom + 10;
        labelRecommendReason.frame = reasonFrame;
        labelRecommendReason.hidden = NO;
        
        labelPrice.frame = CGRectMake(labelPrice.left, labelRecommendReason.bottom + 10, labelPrice.width, labelPrice.height);
        
        _headViewHeight = _loopingView.height + labelProductName.height + labelPrice.height + labelRecommendReason.height + 50 + 10;
        viewTop.frame = CGRectMake(viewTop.left, viewTop.top, viewTop.width, _headViewHeight+50);
    }
    if (_proDetail.totalComm.length > 0 && _proDetail.totalComm != NULL && ![_proDetail.totalComm isEqualToString:@""]) {
        labelCommission.attributedText = [self parserStringWithPreStr:@"总佣金：" contentStr:[NSString stringWithFormat:@"￥%@", _proDetail.totalComm]];
        CGRect commFrame = labelCommission.frame;
        CGFloat commW1 = [@"总佣金：" commonStringWidthForFont:12];
        CGFloat commW2 = [[NSString stringWithFormat:@"￥%@", _proDetail.totalComm] commonStringWidthForFont:17];
        labelCommission.frame = CGRectMake(viewTop.width - commW1 - commW2 - 10, labelPrice.top, commW1 + commW2, commFrame.size.height);
    }
    
    CGRect lineFrame = _line.frame;
    _line.frame = CGRectMake(lineFrame.origin.x, viewTop.bottom - 10, lineFrame.size.width, lineFrame.size.height);
    _collectView.frame=CGRectMake(0, viewTop.bottom-65, APP_SCREEN_WIDTH/2 -1, 55);
    
    _shareView.frame=CGRectMake(_collectView.right+2, _collectView.bottom-55, APP_SCREEN_WIDTH/2, 55);
    _blackLine = [[UIView alloc] initWithFrame:CGRectMake(0, viewTop.bottom - 66, viewTop.width, 1)];
    _blackLine.backgroundColor = RGBCOLOR(240, 240, 240);
    [viewTop addSubview:_blackLine];
    UIView*centerView = [[UIView alloc] initWithFrame:CGRectMake(_collectView.right, viewTop.bottom - 62, 1, 49)];
    centerView.backgroundColor = RGBCOLOR(240, 240, 240);
    [viewTop addSubview:centerView];
    UIImageView*shareimage=[[UIImageView alloc]initWithFrame:CGRectMake(_shareView.frame.size.width/2-30, 15, 20, 20)];
    shareimage.image=[UIImage imageNamed:@"share"];
    [_shareView addSubview:shareimage];
    UILabel*shareLab=[[UILabel alloc]initWithFrame:CGRectMake(shareimage.right+5, 12, 40,30)];
    shareLab.text=@"分享";
    //shareLab.textColor=RGBCOLOR(240, 240, 240);
    [_shareView addSubview:shareLab];
    _collectImage=[[UIImageView alloc]initWithFrame:CGRectMake(_collectView.frame.size.width/2-30, 15, 20, 20)];
    //_collectImage.image=[UIImage imageNamed:@"collect"];
    [_collectView addSubview:_collectImage];
    UILabel*collectLab=[[UILabel alloc]initWithFrame:CGRectMake(_collectImage.right+5, 12, 40,30)];
    collectLab.text=@"收藏";
    //shareLab.textColor=RGBCOLOR(240, 240, 240);
    [_collectView addSubview:collectLab];
    
    
    
    
    labelOldPrice.frame = CGRectMake(labelPrice.right, labelPrice.bottom - 14, labelOldPrice.width, labelOldPrice.height);
    
    labelPrice.text = [NSString stringWithFormat:@"￥%@",_proDetail.currentPrice];
    // 计算当前价格文本的宽度
    labelOldPrice.attributedText = [self addTextCenterLine:[NSString stringWithFormat:@"￥%@", _proDetail.oldPrice]];
    CGFloat labelPriceW= [[NSString stringWithFormat:@"￥%@", _proDetail.currentPrice] commonStringWidthForFont:17];
    CGRect frame = labelPrice.frame;
    frame.size.width = labelPriceW;
    labelPrice.frame = frame;
    frame = labelOldPrice.frame;
    frame.origin.x = labelPrice.right + 5;
    CGFloat labWith=[[NSString stringWithFormat:@"￥%@", _proDetail.oldPrice] commonStringWidthForFont:15];
    frame.size.width=labWith;
    labelOldPrice.frame = frame;
    discountLab.text = [NSString stringWithFormat:@"%@折",_proDetail.discount];
    
    
    discountLab.frame=  CGRectMake(labelOldPrice.right+2,labelPrice.bottom-20, 38, 19);
    
    self.tableHeaderView = viewTop;
    
}

/**
 *  初始化底部View
 */
- (void) initFooterView{
    // 底部view
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 220)];
    footerView.backgroundColor = [UIColor whiteColor];
    self.tableFooterView = footerView;
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 2, 15)];
    UIEdgeInsets inset2 = UIEdgeInsetsMake(1, 1, 1, 1);
    imgView2.image = [[UIImage imageNamed:@"homepage_03"] resizableImageWithCapInsets:inset2 resizingMode:UIImageResizingModeTile];
    [footerView addSubview:imgView2];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(imgView2.right + 5, imgView2.top, 100, 15)];
    title2.text = @"客户服务";
    title2.textColor = RGBCOLOR(25, 25, 25);
    title2.font = [UIFont systemFontOfSize:15];
    [footerView addSubview:title2];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, footerView.width, 0.5)];
    topLine.backgroundColor = RGBCOLOR(238, 238, 238);
    [footerView addSubview:topLine];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, imgView2.bottom + 10, footerView.width, topLine.height)];
    line2.backgroundColor = RGBCOLOR(238, 238, 238);
    [footerView addSubview:line2];
    
    UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(10, line2.bottom + 10, 75, 15)];
    labelTitle1.font = [UIFont systemFontOfSize:15];
    labelTitle1.textColor = RGBCOLOR(200, 200, 200);
    labelTitle1.text = @"客服电话:";
    [footerView addSubview:labelTitle1];
    UILabel *labelContent1 = [[UILabel alloc] initWithFrame:CGRectMake(labelTitle1.right, labelTitle1.top, footerView.width - 20 - labelTitle1.width, 15)];
    labelContent1.font = [UIFont systemFontOfSize:15];
    labelContent1.textAlignment = NSTextAlignmentRight;
    labelContent1.text = @"025-52720027";
    labelContent1.textColor = RGBCOLOR(124, 124, 124);
    [footerView addSubview:labelContent1];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, labelTitle1.bottom + 10, footerView.width, topLine.height)];
    line3.backgroundColor = RGBCOLOR(238, 238, 238);
    [footerView addSubview:line3];
    
    UILabel *labelTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(10, line3.bottom + 10, labelTitle1.width, labelTitle1.height)];
    labelTitle2.font = [UIFont systemFontOfSize:15];
    labelTitle2.textColor = RGBCOLOR(200, 200, 200);
    labelTitle2.text = @"客服时间:";
    [footerView addSubview:labelTitle2];
    UILabel *labelContent2 = [[UILabel alloc] initWithFrame:CGRectMake(labelTitle2.right, labelTitle2.top, footerView.width - 20 - labelTitle2.width, labelContent1.height)];
    labelContent2.font = [UIFont systemFontOfSize:15];
    labelContent2.textAlignment = NSTextAlignmentRight;
    labelContent2.text = @"周一至周五 09：00 - 17：00";
    labelContent2.textColor = RGBCOLOR(124, 124, 124);
    [footerView addSubview:labelContent2];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, labelTitle2.bottom + 10, footerView.width, topLine.height)];
    line4.backgroundColor = RGBCOLOR(238, 238, 238);
    [footerView addSubview:line4];
    
    UILabel *labelTitle3 = [[UILabel alloc] initWithFrame:CGRectMake(10, line4.bottom + 10, labelTitle1.width, labelTitle1.height)];
    labelTitle3.font = [UIFont systemFontOfSize:15];
    labelTitle3.textColor = RGBCOLOR(200, 200, 200);
    labelTitle3.text = @"配送服务:";
    [footerView addSubview:labelTitle3];
    UILabel *labelContent3 = [[UILabel alloc] initWithFrame:CGRectMake(labelTitle3.right, labelTitle3.top, footerView.width - 20 - labelTitle3.width, labelContent1.height)];
    labelContent3.font = [UIFont systemFontOfSize:15];
    labelContent3.textAlignment = NSTextAlignmentRight;
    labelContent3.text = @"运费10元(满98元包邮)";
    labelContent3.textColor = RGBCOLOR(124, 124, 124);
    [footerView addSubview:labelContent3];
    
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(0, labelTitle3.bottom + 10, footerView.width, topLine.height)];
    line5.backgroundColor = RGBCOLOR(238, 238, 238);
    [footerView addSubview:line5];
    
    UILabel *labelTitle4 = [[UILabel alloc] initWithFrame:CGRectMake(10, line5.bottom + 10, labelTitle1.width, labelTitle1.height)];
    labelTitle4.font = [UIFont systemFontOfSize:15];
    labelTitle4.textColor = RGBCOLOR(200, 200, 200);
    labelTitle4.text = @"发货时间:";
    [footerView addSubview:labelTitle4];
    UILabel *labelContent4 = [[UILabel alloc] initWithFrame:CGRectMake(labelTitle4.right, labelTitle4.top, footerView.width - 20 - labelTitle4.width, labelContent1.height)];
    labelContent4.font = [UIFont systemFontOfSize:15];
    labelContent4.textAlignment = NSTextAlignmentRight;
    labelContent4.text = @"全天发货，17点前付款当天发货";
    labelContent4.textColor = RGBCOLOR(124, 124, 124);
    [footerView addSubview:labelContent4];
    
    UIView *line6 = [[UIView alloc] initWithFrame:CGRectMake(0, labelTitle4.bottom + 10, footerView.width, topLine.height)];
    line6.backgroundColor = RGBCOLOR(238, 238, 238);
    [footerView addSubview:line6];
    
    UILabel *labelTitle5 = [[UILabel alloc] initWithFrame:CGRectMake(10, line6.bottom + 10, labelTitle1.width, labelTitle1.height)];
    labelTitle5.font = [UIFont systemFontOfSize:15];
    labelTitle5.textColor = RGBCOLOR(200, 200, 200);
    labelTitle5.text = @"相关服务:";
    [footerView addSubview:labelTitle5];
    UILabel *labelContent5 = [[UILabel alloc] initWithFrame:CGRectMake(labelTitle5.right, labelTitle5.top, footerView.width - 20 - labelTitle5.width, labelContent1.height)];
    labelContent5.font = [UIFont systemFontOfSize:15];
    labelContent5.textAlignment = NSTextAlignmentRight;
    labelContent5.text = @"14天无理由退货";
    labelContent5.textColor = RGBCOLOR(124, 124, 124);
    [footerView addSubview:labelContent5];
    
    UIView *line7 = [[UIView alloc] initWithFrame:CGRectMake(0, labelTitle5.bottom + 10, footerView.width, topLine.height)];
    line6.backgroundColor = RGBCOLOR(238, 238, 238);
    [footerView addSubview:line7];
}

/**
 *  加载商品详情图片行高
 */

- (void)initProDetailImages
{
    UIImageView *imageView = [[UIImageView alloc]init];
    
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_proDetail.descList[arryIndex]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil) {
            [imageView removeFromSuperview];
            [cellHeightArry addObject:[NSString stringWithFormat:@"%f",image.size.height / image.size.width * APP_SCREEN_WIDTH]];
            [self reloadData];
        }
        if (arryIndex != [_proDetail.descList count] - 1) {
            arryIndex += 1;
            [self initProDetailImages];
        }
    }];
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        return view;
    }
    else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 45)];
        view.backgroundColor  = [UIColor whiteColor];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 2, 15)];
        UIEdgeInsets inset = UIEdgeInsetsMake(1, 1, 1, 1);
        imgView.image = [[UIImage imageNamed:@"homepage_03"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeTile];
        [view addSubview:imgView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + 5, imgView.top, 100, 15)];
        title.text = @"商品详情";
        title.textColor = RGBCOLOR(25, 25, 25);
        title.font = [UIFont systemFontOfSize:15];
        [view addSubview:title];
        return view;
        
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSArray *imgList = _proDetail.descList;
    
    //    return imgList.count;
    if (section==0)
    {
        return 1;
    }
    else
    {
        return cellHeightArry.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identified = @"productDetailCell";
    static NSString *reuseID = @"Cell";
    if (indexPath.section==0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID] ;
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 181*APP_SCREEN_WIDTH/750)];
            if ([_proDetail.isBW isEqualToString:@"0"])
            {
                imageView.image=[UIImage imageNamed:@"001"];
            }
            else
            {
                imageView.image=[UIImage imageNamed:@"002"];
            }
            
            
            [cell.contentView addSubview:imageView];
            
            NSLog(@"创建");
        }
        return cell;
        
    }
    else{
        ZMProDetailTableViewCell *cell = [self dequeueReusableCellWithIdentifier:identified];
        if (!cell) {
            cell = [[ZMProDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
        }
        [cell.imgDetail sd_setImageWithURL:[NSURL URLWithString:_proDetail.descList[indexPath.row]]];
        [cell setImageHeigh:[cellHeightArry[indexPath.row] floatValue]];
        
        
        return cell;
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0)
    {
        return 6;
    }
    return 45;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0)
    {
        return 181*APP_SCREEN_WIDTH/750;
    }
    
    return [cellHeightArry[indexPath.row] floatValue];
    
    
}

/**
 *  在文本中间添加横划线
 *
 *  @param text
 *
 *  @return NSMutableAttributedString
 */
- (NSMutableAttributedString *) addTextCenterLine:(NSString *) text{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attrString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, text.length)];
    [attrString addAttribute:NSStrikethroughColorAttributeName value:RGBCOLOR(168, 168, 170) range:NSMakeRange(0, text.length)];
    
    return attrString;
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
                       value:RGBCOLOR(193, 192, 194)
                       range:NSMakeRange(0, preStr.length)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(248, 141, 167)
                       range:NSMakeRange(preStr.length, str.length)];
    return attrString;
}

/**
 *  富文本，拼接字符串
 *
 *  @param preStr 待拼接的字符串1
 *  @param str    待拼接的字符串2
 *
 *  @return 拼接好的字符串
 */
- (NSMutableAttributedString *) parserStringWithPreStr:(NSString *)preStr contentStr:(NSString *)str{
    NSString *postStr = [NSString stringWithFormat:@"%@%@", preStr, str];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:postStr];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(115, 115, 115)
                       range:NSMakeRange(0, preStr.length)];
    UIFont *preFont = [UIFont systemFontOfSize:12];
    [attrString addAttribute:NSFontAttributeName value:preFont range:NSMakeRange(0, preStr.length)];
    
    UIFont *font = [UIFont systemFontOfSize:15];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(preStr.length, str.length)];
    return attrString;
}

- (UIImage *)getTableHeaderImage{
    return imgHead.image;
}

@end
