//
//  ZMAddressViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/4.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMAddressViewController.h"
#import "ZMEditAddressViewController.h"

@interface ZMAddressViewController ()

@end

@implementation ZMAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath != super.curSelectedIndex) {
        WYAAddressListCell *cell = (WYAAddressListCell *)[super.tableView cellForRowAtIndexPath:indexPath];
        WYAAddressListCell *preCell = (WYAAddressListCell *)[super.tableView cellForRowAtIndexPath:super.curSelectedIndex];
        [preCell setSelected:NO];
        [cell setSelected:YES];
    }
    super.curSelectedIndex = indexPath;
    ZMAddress *address = super.addressList[indexPath.row];
    
    ZMEditAddressViewController *editAddressVC = [[ZMEditAddressViewController alloc] init];
    editAddressVC.editAddress = address;
    [self.navigationController pushViewController:editAddressVC animated:YES];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self loadData];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WYAAddressListCell *cell = (WYAAddressListCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.imgIndicate.hidden = YES;
    return cell;
}

@end
