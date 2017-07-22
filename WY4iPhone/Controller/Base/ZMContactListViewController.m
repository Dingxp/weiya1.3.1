//
//  ZMContactListViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/15.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMContactListViewController.h"
#import "ZMContact.h"
#import "ZMContactTableViewCell.h"
#import "ZMUser.h"
@interface ZMContactListViewController ()
{
    ZMUser*user;
}
@end

@implementation ZMContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT-20) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView];
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.title=@"邀请好友";
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    _contactArray = [[NSMutableArray alloc] init];
    CFErrorRef error = NULL;
    //创建一个新的通讯录对象 数据从系统通讯录中读取
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, &error);
    
    //请求访问 等用户做出一定选择后才会执行para2  para2为一个代码块 传入参数两个1.是否授权成功 2.错误信息
    ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
       // NSLog(@"1___%d____%@", granted, error);
    });
   // NSLog(@"2____%@", addressBookRef);
    //1和2哪个先执行  、
    //2先执行
    
    //获取系统通讯录中的所有联系人
    CFArrayRef arrayRef = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
   // NSLog(@"%@", arrayRef);
    
    //获取数组的个数
    CFIndex index = CFArrayGetCount(arrayRef);
    //循环取出数组中的值
    for (CFIndex idx=0; idx<index; idx++)
    {
        //从数组中取出一条记录 该记录可能表示一个人或一个组
        ABRecordRef recordRef = CFArrayGetValueAtIndex(arrayRef, idx);
        //从该条记录中获取全名
        CFStringRef compositeName = ABRecordCopyCompositeName(recordRef);
        //NSLog(@"compositeName___%@", compositeName);
        //取电话号码 电话号码有可能是多值 采用ABMultiValueRef接收
        ABMultiValueRef multiValueRef = ABRecordCopyValue(recordRef, kABPersonPhoneProperty);
        //从多值中根据索引取值
        CFStringRef phoneNumber = ABMultiValueCopyValueAtIndex(multiValueRef, 0);
        
        //构建数据源
        ZMContact *contact = [ZMContact new];
        contact.name = (__bridge NSString *)compositeName;
        contact.phoneNumber = (__bridge NSString *)phoneNumber;
        [_contactArray addObject:contact];
           }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contactArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //定义静态重用标识符
    static NSString *cellIdentifier = @"Cell";
    //根据重用标识符从重用队列中出列一个可重用的单元格
    ZMContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //判断单元格是否可用 如果不可用 创建
    if (!cell)
    {
        //根据重用标识符和风格创建一个单元格
        cell = [[ZMContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
   
    }
    
    ZMContact *contact = _contactArray[indexPath.row];
    [cell.btn addTarget:self action:@selector(contactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn.tag=indexPath.row;
    cell.textLabel.text=[NSString stringWithFormat:@"%@", contact.name];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else
    {
        return 0;
    }
    
}
-(void)contactBtnClick:(UIButton*)btn
{
   ZMContact *contact = _contactArray[btn.tag];
    NSLog(@"==%@",contact.name);
    if (!contact.phoneNumber)
    {
        [SVProgressHUD showErrorWithStatus:@"你存的手机号为空"];
        return;
    }
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];            messageController.delegate = self;
     messageController.messageComposeDelegate = self;
    //拼接并设置短信内容 7
    NSString *messageContent;
    if (user.invitationCode)
    {
        messageContent = [NSString stringWithFormat:@"国内外精选商品都在这了，购物还有佣金拿，你的好友也在用额！http://dwz.cn/2sLfEl。我的分享码%@。",user.invitationCode];

    }
    else
    {
       messageContent = [NSString stringWithFormat:@"国内外精选商品都在这了，购物还有佣金拿，你的好友也在用额!http://dwz.cn/2sLfEl。"];
    }
      messageController.body = messageContent;                         //设置发送给谁11
    messageController.recipients = @[contact.phoneNumber];            //推到发送试图控制器14
    [self presentViewController:messageController animated:YES completion:^{
       
    }];
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
