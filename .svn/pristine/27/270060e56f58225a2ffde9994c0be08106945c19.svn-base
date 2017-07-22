//
//  ZMAddAddressViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/27.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMAddAddressViewController.h"
#import "ZMProvince.h"
#import "ZMCity.h"
#import "ZMArea.h"
@interface ZMAddAddressViewController () <UIGestureRecognizerDelegate, UITextFieldDelegate>{
    BaseRequest *baseRequest;
    ZMUser *user;
    UIView *backView;
    UIToolbar *toolBar;
    NSInteger recordFirstRow;
    NSInteger recordSecondRow;
    UIButton *btnSave;
    
}

@end

@implementation ZMAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加收货地址";
    self.view.backgroundColor = RGBCOLOR( 240, 240, 240);
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self initView];
    [self loadData];
    [self requestProvinceCity];
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.width, 225)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.width, 1)];
    line.backgroundColor = RGBCOLOR(232, 232, 232);
    [view addSubview:line];
    
    _tfName = [[UITextField alloc] initWithFrame:CGRectMake(0, line.bottom, view.width, 44)];
    _tfName.placeholder = @" * 收货人姓名";
    _tfName.font = [UIFont systemFontOfSize:14];
    _tfName.tag = 50001;
    _tfName.delegate = self;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _tfName.leftView = leftView;
    _tfName.leftViewMode = UITextFieldViewModeAlways;
    [view addSubview:_tfName];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, _tfName.bottom, line.width, line.height)];
    line1.backgroundColor = RGBCOLOR(232, 232, 232);
    [view addSubview:line1];
    
    _tfTelNo = [[UITextField alloc] initWithFrame:CGRectMake(0, line1.bottom, _tfName.width, _tfName.height)];
    _tfTelNo.placeholder = @" * 手机号码";
    _tfTelNo.font = [UIFont systemFontOfSize:14];
    _tfTelNo.tag = 50002;
    _tfTelNo.delegate = self;
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _tfTelNo.leftView = leftView;
    _tfTelNo.leftViewMode = UITextFieldViewModeAlways;
    [view addSubview:_tfTelNo];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _tfTelNo.bottom, line.width, line.height)];
    line2.backgroundColor = RGBCOLOR(232, 232, 232);
    [view addSubview:line2];
    
    _tfProvinceCity = [[UITextField alloc] initWithFrame:CGRectMake(10, line2.bottom, _tfName.width - 10 , _tfName.height)];
    _tfProvinceCity.placeholder = @" * 省市地址";
    _tfProvinceCity.tag = 50003;
    _tfProvinceCity.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    _tfProvinceCity.returnKeyType = UIReturnKeyDone;
    _tfProvinceCity.delegate = self;
    _tfProvinceCity.font = [UIFont systemFontOfSize:14];
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _tfTelNo.leftView = leftView;
    _tfTelNo.leftViewMode = UITextFieldViewModeAlways;
    _tfProvinceCity.userInteractionEnabled = YES;
    [view addSubview:_tfProvinceCity];
    
    UIImageView *imgRightIndiate = [[UIImageView alloc] initWithFrame:CGRectMake(_tfProvinceCity.right - 10 - 9 - 5, (_tfProvinceCity.height - 13) / 2, 9, 13)];
    imgRightIndiate.image = [UIImage imageNamed:@"mine_rightGray"];
    [_tfProvinceCity addSubview:imgRightIndiate];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, _tfProvinceCity.bottom, line.width, line.height)];
    line3.backgroundColor = RGBCOLOR(232, 232, 232);
    [view addSubview:line3];
    
    _tfDetailAddress = [[UITextField alloc] initWithFrame:CGRectMake(0, line3.bottom, _tfName.width, _tfName.height)];
    _tfDetailAddress.placeholder = @" * 详细地址";
    _tfDetailAddress.font = [UIFont systemFontOfSize:14];
    _tfDetailAddress.tag = 50004;
    _tfDetailAddress.delegate = self;
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _tfDetailAddress.leftView = leftView;
    _tfDetailAddress.leftViewMode = UITextFieldViewModeAlways;
    [view addSubview:_tfDetailAddress];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, _tfDetailAddress.bottom, line.width, line.height)];
    line4.backgroundColor = RGBCOLOR(232, 232, 232);
    [view addSubview:line4];
    _tfIDcard=[[UITextField alloc]initWithFrame:CGRectMake(0, line4.bottom, _tfName.width, _tfName.height)];
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    
    _tfIDcard.leftView = leftView;
    _tfIDcard.leftViewMode = UITextFieldViewModeAlways;
    _tfIDcard.font = [UIFont systemFontOfSize:14];
    _tfIDcard.delegate=self;
    _tfIDcard.placeholder=@" * 收货人的身份证号码（选填）";
    [view addSubview:_tfIDcard];
    CGFloat btnH = 53;
    CGFloat btnTitleFont = 16;
    CGFloat btnLeft = 25;
    _indicatorImageView = [UIButton new];
    _indicatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _indicatorImageView.frame=CGRectMake(btnLeft, view.bottom+20, 20, 20);
    [_indicatorImageView setBackgroundImage:[UIImage imageNamed:@"emptyRing"] forState:UIControlStateNormal];
    [_indicatorImageView setBackgroundImage:[UIImage imageNamed:@"hookRing"] forState:UIControlStateSelected];
    [_indicatorImageView addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_indicatorImageView];
    
    
    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(_indicatorImageView.right, view.bottom+20, 120, 30)];
    lab.text=@"设为默认收货地址";
    lab.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:lab];
    
    btnSave = [[UIButton alloc] initWithFrame:CGRectMake(btnLeft, view.bottom + 55, self.view.width - btnLeft * 2, btnH)];
    btnSave.backgroundColor = RGBCOLOR(255, 0, 90);
    btnSave.layer.cornerRadius = 5;
    [btnSave setTitle:@"保存" forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(btnSaveClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnSave.titleLabel.font = [UIFont systemFontOfSize:btnTitleFont];
    [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btnSave];
}
-(void)btnclick
{
    if (_indicatorImageView.selected==NO)
    {
        _indicatorImageView.selected=YES;
    }
    else
    {
        _indicatorImageView.selected=NO;
    }
    
    
}
- (void) loadData{
    baseRequest = [BaseRequest sharedInstance];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
}
#pragma mark - Custom Method
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) btnSaveClicked:(UIButton *)button{
    if ([_tfDetailAddress.text isEmpty] || [_tfName.text isEmpty] || [_tfProvinceCity.text isEmpty] || [_tfTelNo.text isEmpty]) {
        [SVProgressHUD showInfoWithStatus:@"请将信息填写完整"];
        return;
    }
    if (![_tfTelNo.text isTelephone]) {
        [SVProgressHUD showInfoWithStatus:@"手机号码格式不正确"];
        return;
    }
    if (_tfName.text.length >= 32) {
        [SVProgressHUD showInfoWithStatus:@"请输入32个字符以下的姓名"];
    }
    ZMAddress *address = [ZMAddress addressInstance];
    [self addNewAddressWithregUserId:user.userId consignee:_tfName.text telNo:_tfTelNo.text addrProvince:address.addrProvince addrCity:address.addrCity addrArea:address.addrArea addr:_tfDetailAddress.text zipCode:@"" isDefault:@"1"];
}

/**
 *  新建地址
 *
 *  @param regUserId    会员ID
 *  @param consignee    会员姓名
 *  @param telNo        电话号码
 *  @param addrProvince 省
 *  @param addrCity     市
 *  @param addrArea     区
 *  @param addr         详细地址
 *  @param zipCode      邮编
 *  @param isDefault    是否设为默认地址
 */
- (void) addNewAddressWithregUserId:(NSString *)regUserId consignee:(NSString *)consignee telNo:(NSString *)telNo addrProvince:(NSString *)addrProvince addrCity:(NSString *)addrCity addrArea:(NSString *)addrArea addr:(NSString *)addr zipCode:(NSString *)zipCode isDefault:(NSString *)isDefault{
    NSString *url = @"app/crm/addr/insertAddr.do";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:consignee forKey:@"consignee"];
    [params setValue:telNo forKey:@"telNo"];
    [params setValue:addrProvince forKey:@"addrProvince"];
    [params setValue:addrCity forKey:@"addrCity"];
    [params setValue:addr forKey:@"addr"];
    [params setValue:zipCode forKey:@"zipCode"];
    [params setValue:isDefault forKey:@"isDefault"];
    [params setValue:addrArea forKey:@"addrArea"];
    [params setValue:_tfIDcard.text forKey:@"identityCard"];
    if (_indicatorImageView.selected==YES)
    {
        [params setValue:@"1" forKey:@"isDefault"];
        
    }
    else
    {
        [params setValue:@"0" forKey:@"isDefault"];
    }
    
    [baseRequest request:url parameters:params success:^(id responseObject) {
        //        NSLog(@"add new address :%@", responseObject[@"result"]);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 50003) {
        
        //收起所有键盘
        for (int i = 50000; i < 50005; i++) {
            UITextField *field = (UITextField *)[self.view viewWithTag:i];
            [field resignFirstResponder];
        }
        
        if (_dataPicker == nil) {
            backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];
            backView.backgroundColor = [UIColor blackColor];
            backView.alpha = 0.3;
            [self.view addSubview:backView];
            btnSave.hidden=YES;
            [self createPickerView];
            
        }else {
            [backView setHidden:NO];
            [UIView animateWithDuration:0.2 animations:^{
                backView.alpha = 0;
                
                backView.alpha = 0.3;
            }];
            btnSave.hidden=YES;
            
        }
        [self showToolbar];
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //    NSLog(@"tag END = %ld",(long)textField.tag);
    [textField resignFirstResponder];
    return YES;
}


- (void)showToolbar {
    if(!toolBar){
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.height-216-44, self.view.width, 44)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *comp = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(complete)];
        toolBar.items = @[space,comp];
        [self.view addSubview:toolBar];
    }else {
        toolBar.hidden = NO;
    }
    
    
}

- (void)complete
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.2;
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromBottom];
    
    
    
    [UIView animateWithDuration:0.2 animations:^{
        backView.alpha = 0.3;
        
        backView.alpha = 0;
        
        [_dataPicker.layer addAnimation:animation forKey:nil];
    }];
    
    toolBar.hidden = YES;
    //    _addressPicker.hidden = YES;
    backView.hidden = YES;
    btnSave.hidden=NO;
}
-(void)createPickerView
{
    _dataPicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.height - 216, backView.width, 216)];
    _dataPicker.dataSource = self;
    //    设置代理
    _dataPicker.backgroundColor=[UIColor whiteColor];
    _dataPicker.delegate = self;
    [backView addSubview:_dataPicker];
    
}
- (void) requestProvinceCity{
    NSString *url = @"app/sys/sysaddr/findSysAddress.do";
    NSMutableDictionary*parameters=[NSMutableDictionary new];
    [[BaseRequest sharedInstance] request:url parameters:parameters success:^(id responseObject) {
       // NSLog(@"channel item:－－%@", responseObject);
        
        
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"])
            
        {
            NSArray*arr=responseObject[@"result"];
            if (arr.count==0)
            {
                return ;
            }
            NSMutableArray *orderLists = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in responseObject[@"result"]) {
                ZMProvince *detail = [ZMProvince orderDetailsWithDictionary:dict];
                [orderLists addObject:detail];
            }
            _provinceArr = orderLists;
        }else{
            [SVProgressHUD showInfoWithStatus:@"加载失败"];
        }
        
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
    }];
}
//Component  成分 部分
//设置picker中🈶多少个区

//返回值为整数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
    
}

// 设置每个区中有多少行

//区和行 都是从0开始
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    //    设置0区  3行
    if (component == 0)
    {
        return _provinceArr.count;
    }
    else if (component==1)
    {
        NSInteger currentRow = [pickerView selectedRowInComponent:0];
        ZMProvince*provice=_provinceArr[currentRow];
        if (provice.cityArr.count==0||provice.cityArr==nil)
        {
            return 0;
            
        }
        else
        {
            return provice.cityArr.count;
        }
        
    }
    else
    {
        NSInteger currentRow = [pickerView selectedRowInComponent:0];
        ZMProvince*provice=_provinceArr[currentRow];
        if (provice.cityArr.count==0||provice.cityArr==nil)
        {
            return 0;
            
        }
        else
        {
            NSInteger currentRow1 = [pickerView selectedRowInComponent:1];
            ZMCity*city=provice.cityArr[currentRow1];
            if (city.areaArr.count==0||city.areaArr==nil)
            {
                return 0;
            }
            else
            {
                return city.areaArr.count;
            }
        }
        
        
        
    }
    
    
}

#pragma mark -
#pragma mark picker的代理方法

//设置标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //    设置第0个区
    
    if (component == 0)
    {
        
        //        通过row 在数组中 取值
        
        ZMProvince*provice = [_provinceArr objectAtIndex:row];
        
        return provice.addrProvince;
    }
    else if(component == 1)
    {
        NSInteger currentRow = [pickerView selectedRowInComponent:0];
        ZMProvince*provice=_provinceArr[currentRow];
        ZMCity*city = [provice.cityArr objectAtIndex:row];
        return city.addrcity;
    }
    else
    {
        NSInteger currentRow = [pickerView selectedRowInComponent:0];
        ZMProvince*provice=_provinceArr[currentRow];
        NSInteger currentRow1 = [pickerView selectedRowInComponent:1];
        ZMCity*city=provice.cityArr[currentRow1];
        ZMArea*area = [city.areaArr objectAtIndex:row];
        return area.addrarea;
    }
    //     被选择的行 在某一个区中
}

//已经选择了某个区的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    //    只有选择0区时才默认选择第0行  所以添加判断
    if (component == 0)
    {
        NSLog(@"===============");
        //    刷新所有的区
        //    [pickerView reloadAllComponents];
        //    指定要刷新的区
        [pickerView reloadComponent:1];
        
        //指定选择某个区中的某一行
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
        ZMProvince*provice = [_provinceArr objectAtIndex:row];
        _AddressProvince=provice.addrProvince;
        if (provice.cityArr.count>0)
        {
            ZMCity*city=provice.cityArr[0];
            _AddressCity=city.addrcity;
            if (city.areaArr.count>0)
            {
                ZMArea*area=city.areaArr[0];
                _AddressArea=area.addrarea;
                recordFirstRow=row;
            }
            else
            {
                return;
            }
            
        }
        else
        {
            return;
        }
        
        
        
    }
    if (component==1)
    {
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
        ZMProvince*provice = [_provinceArr objectAtIndex:recordFirstRow];
        _AddressProvince=provice.addrProvince;

        if (provice.cityArr.count>0)
        {
            ZMCity*city=provice.cityArr[row];
            _AddressCity=city.addrcity;
            if (city.areaArr.count>0)
            {
                ZMArea*area=city.areaArr[0];
                _AddressArea=area.addrarea;
                recordSecondRow=row;
            }
            else
            {
                return;
            }
            
        }
        else
        {
            return;
        }
        
        
        
    }
    if (component==2)
    {
        ZMProvince*provice = [_provinceArr objectAtIndex:recordFirstRow];
        _AddressProvince=provice.addrProvince;
        if (provice.cityArr.count>0)
        {
            ZMCity*city=provice.cityArr[recordSecondRow];
            _AddressCity=city.addrcity;
            if (city.areaArr.count>0)
            {
                ZMArea*area=city.areaArr[row];
                _AddressArea=area.addrarea;
            }
            else
            {
                return;
            }
            
        }
        else
        {
            return;
        }
        
        
    }
    
    _tfProvinceCity.text = [NSString stringWithFormat: @"%@ %@ %@",_AddressProvince,_AddressCity,_AddressArea];
    [ZMAddress addressInstance].addrProvince = [NSString stringWithFormat:@"%@",_AddressProvince];
    [ZMAddress addressInstance].addrCity = [NSString stringWithFormat:@"%@", _AddressCity];
    [ZMAddress addressInstance].addrArea = [NSString stringWithFormat:@"%@", _AddressArea];
}
@end
