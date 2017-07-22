//
//  ZMPersonRelationshipTableViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMPersonRelationshipTableViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"

@interface ZMPersonRelationshipTableViewController (){
    ZMUser*user;
}

@end

@implementation ZMPersonRelationshipTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人脉圈";
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    [self initView];
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}
- (void) initView{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.width-20, 240)];
    view1.backgroundColor = RGBCOLOR(245, 50, 109);
    [self.view addSubview:view1];
    
    UILabel *lbTotal = [[UILabel alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH/2-50, 30, 80, 35)];
    lbTotal.font = [UIFont systemFontOfSize:20];
    lbTotal.textColor = [UIColor whiteColor];
    lbTotal.text = @"人脉总数";
    [view1 addSubview:lbTotal];
    
    _labelCountTotal = [[UILabel alloc] initWithFrame:CGRectMake(lbTotal.left, lbTotal.bottom , lbTotal.width, 30)];
    _labelCountTotal.font = [UIFont systemFontOfSize:15];
    _labelCountTotal.textColor = [UIColor whiteColor];
    _labelCountTotal.font=[UIFont systemFontOfSize:25];
    _labelCountTotal.textAlignment=NSTextAlignmentCenter;
    _labelCountTotal.text = @"0";
    [view1 addSubview:_labelCountTotal];
    
    UILabel *lbFirst = [[UILabel alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH/4-65 , 170, 120, 30)];
    lbFirst.font = [UIFont systemFontOfSize:18];
    lbFirst.textColor = [UIColor whiteColor];
    lbFirst.text = @"一级人脉总数";
    [view1 addSubview:lbFirst];
    
    _labelcountFirst = [[UILabel alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH/4-65, 200, 120, 30)];
    _labelcountFirst.font = [UIFont systemFontOfSize:25];
    _labelcountFirst.textColor = [UIColor whiteColor];
    _labelcountFirst.text = @"0";
    _labelcountFirst.textAlignment=NSTextAlignmentCenter;

    [view1 addSubview:_labelcountFirst];
    
    UILabel *lbSecond = [[UILabel alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH*0.75-65, 170, 120, 30)];
    lbSecond.font = [UIFont systemFontOfSize:18];
    lbSecond.textColor = [UIColor whiteColor];
    lbSecond.text = @"二级人脉总数";
    [view1 addSubview:lbSecond];
    
    _labelcountSecond = [[UILabel alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH*0.75-65, 200, 120, 30)];
    _labelcountSecond.font = [UIFont systemFontOfSize:25];
    _labelcountSecond.textColor = [UIColor whiteColor];
    _labelcountSecond.textAlignment=NSTextAlignmentCenter;

    _labelcountSecond.text = @"0";
    [view1 addSubview:_labelcountSecond];
    UIView*lineview=[[UIView alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH/2-11, 170, 2, 60)];
    lineview.backgroundColor=[UIColor whiteColor];
    [view1 addSubview:lineview];
    UILabel*textLab=[[UILabel alloc]initWithFrame:CGRectMake(5, view1.bottom, APP_SCREEN_WIDTH-10, 70)];
    textLab.text=@"*人脉总数包含一级、二级和其他等级人数的总和。";
    textLab.numberOfLines=0;
    textLab.textColor=RGBCOLOR(102, 102, 102);
    // lab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:textLab];
}

- (void) loadData{
    [self requestRelationshipByRegUserId:user.userId];
}

/**
 *  刷新UI界面
 *
 *  @param dictionary <#dictionary description#>
 */
- (void) refreshViewWithDictionary:(NSDictionary *)dictionary{
    _labelcountFirst.text = [NSString stringWithFormat:@"%@", dictionary[@"countFirst"]];
    _labelcountSecond.text = [NSString stringWithFormat:@"%@", dictionary[@"countSecond"]];
    _labelCountTotal.text = [NSString stringWithFormat:@"%@", dictionary[@"countTotal"]];
}

/**
 *  人物关系
 *
 *  @param regUserId 会员ID
 */
- (void) requestRelationshipByRegUserId:(NSString *)regUserId{
    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/findRelationship.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            [self refreshViewWithDictionary:responseObject[@"result"]];
        }
//        NSLog(@"人脉圈:%@", responseObject[@"result"]);
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

@end
