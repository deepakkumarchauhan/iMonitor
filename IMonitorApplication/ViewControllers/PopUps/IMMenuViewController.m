//
//  IMMenuViewController.m
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 11/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMMenuViewController.h"
#import "IMMenuTableViewCell.h"
static NSString *cellIdentifier = @"menuCellID";

@interface IMMenuViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate> {
    
    NSMutableArray *menuArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;

@end

@implementation IMMenuViewController


#pragma mark - UIView Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Call Initial Method
    [self initialMethod];

}

#pragma mark - Custom Method
-(void)initialMethod {
    
    // Register TableView
    [self.tableView registerNib:[UINib nibWithNibName:@"IMMenuTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    self.tableView.alwaysBounceVertical = NO;
    self.tableView.layer.cornerRadius = 10.0;
    
    // Alloc Array
    menuArray = [[NSMutableArray alloc]initWithObjects:@"About us",@"Enquiry",@"Refer a Friend",@"Sync Device Status",@"Device Refresh",@"Customer Support",@"Logout",@"Home",nil];
    
   // [self performSelector:@selector(subscribe) withObject:self afterDelay:0.1];
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IMMenuTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.menuTitleLabel.text = [menuArray objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 35.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate menuItemClick:indexPath.row];
    
}

-(void)subscribe {
    
    self.tableHeightConstraint.constant = self.tableView.contentSize.height+7;
}


#pragma mark - UIMemory Management Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
