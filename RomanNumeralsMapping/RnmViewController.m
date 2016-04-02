//
//  ViewController.m
//  RomanNumeralsMapping
//
//  Created by Hussain  on 30/3/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

#import "RnmViewController.h"
#import "RnmCustomInputTableViewCell.h"
#import "Constants.h"
@interface RnmViewController ()
@end

@implementation RnmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return kRomannumeralsconversion;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return kTableViewFooterMessage;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RnmCustomInputTableViewCell *cell= (RnmCustomInputTableViewCell*)[tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    [cell setRepresentedObject:self];
    return cell;
}
@end
