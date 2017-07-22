//
//  ZMContactListViewController.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/15.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
@interface ZMContactListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView*tableView;
@property (strong, nonatomic) NSMutableDictionary *contactDic;
@property (strong, nonatomic) NSArray *sortedKeys;
@property (strong,nonatomic)NSMutableArray*contactArray;
@end
