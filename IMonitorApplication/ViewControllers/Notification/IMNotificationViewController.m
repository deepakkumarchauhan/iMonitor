//
//  IMNotificationViewController.m
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 08/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMNotificationViewController.h"
#import "IMNotificationTableViewCell.h"
#import "KILabel.h"
#import "Macro.h"
#import "FTPopOverMenu.h"
#import "WYPopoverController.h"
#import "IMMenuViewController.h"
#import "IMStaticViewController.h"
#import "IMCustomerSupportViewController.h"
#import "IMNotificationViewController.h"
#import "IMAppUtility.h"
#import "IMEnquiryViewController.h"
#import "IMLogoutViewController.h"
#import "IMHomeDeviceViewController.h"
#import "AppDelegate.h"
#import "IMLogoutViewController.h"
#import "IMSynchDeviceModelViewController.h"

static NSString *cellIdentifier = @"notificationCellID";

@interface IMNotificationViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate, LogoutProtocolDelegate> {
    
    NSMutableArray *notificationArray;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation IMNotificationViewController


#pragma mark - UIView Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Call Initial Method
    [self initialMethod];
}

#pragma mark - Custom Method
-(void)initialMethod {
    
    // Register TableView
    [self.tableView registerNib:[UINib nibWithNibName:@"IMNotificationTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    self.tableView.estimatedRowHeight = 102.0;
    
    // Alloc Array
    notificationArray = [[NSMutableArray alloc]initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Battery 10%",@"title",@"Device no. 14 battery has low",@"alertTitle",@"Device no. 14 need to attention, only 10% has remain, connect the charger soon.",@"notificationDescription",@"11:31 AM",@"time", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Door Open",@"title",@"Someone stranger enter into the room",@"alertTitle",@"Someone open the door, his/her CCTV footage recorded, click to play the video.",@"notificationDescription",@"08:23 PM",@"time", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Product Hunt",@"title",@"On time",@"alertTitle",@"The door closed as usual\nNo any threatened.",@"notificationDescription",@"Yesterday",@"time", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Door Open",@"title",@"Someone stranger enter into the room",@"alertTitle",@"Someone open the door, his/her CCTV footage not recorder, Please ON the camera by click here.",@"notificationDescription",@"Mar 12",@"time", nil],nil];
    
}


#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return notificationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IMNotificationTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary *dict = [notificationArray objectAtIndex:indexPath.row];
    
    cell.notificationTitleLabel.text = [dict valueForKey:@"title"];
    cell.notificationAlertTitleLabel.text = [dict valueForKey:@"alertTitle"];
    cell.notificationDescriptionLabel.text = [dict valueForKey:@"notificationDescription"];
    cell.timeLabel.text = [dict valueForKey:@"time"];
    
    
    // Block to handle all our taps, we attach this to all the label's handlers
    KILinkTapHandler tapHandler = ^(KILabel *label, NSString *string, NSRange range) {
        [self tappedLink:string cellForRowAtIndexPath:indexPath];
    };
    
    cell.notificationDescriptionLabel.userHandleLinkTapHandler = tapHandler;
    cell.notificationDescriptionLabel.urlLinkTapHandler = tapHandler;
    cell.notificationDescriptionLabel.hashtagLinkTapHandler = tapHandler;


    return cell;
}


#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}


- (void)tappedLink:(NSString *)link cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [NSString stringWithFormat:@"Tapped %@", link];
    NSString *message = [NSString stringWithFormat:@"You tapped %@ in section %@, row %@.",
                         link,
                         @(indexPath.section),
                         @(indexPath.row)];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark - UIMemory Management Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -******************* Button Action & Selector Methods ******************-
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)menuButtonAction:(UIButton *)sender {
    
    //Menu Button
    [FTPopOverMenu showForSender:sender withMenuArray:@[@"Home", @"About Us", @"Enquiry", @"Refer a Friend", @"Sync DeviceModel Status", @"DeviceModel Refresh", @"Customer Support", @"Logout"] imageArray:@[@"v",@"w",@"x",@"y",@"z",@"A",@"B",@"T"] headerTitle:@"Hello Ratan!!" doneBlock:^(NSInteger selectedIndex) {
        switch (selectedIndex) {
            case 0: {
                BOOL isControllerFound = NO;
                NSArray *viewControllerArray = [self.homeNavigationController viewControllers];
                for (UIViewController *viewControllerObj in viewControllerArray) {
                    if([viewControllerObj isKindOfClass:[IMHomeDeviceViewController class]]) {
                        [self.homeNavigationController popToViewController:viewControllerObj animated:YES];
                        isControllerFound = YES;
                        break;
                    }
                }
                if(!isControllerFound) {
                    IMHomeDeviceViewController *objVC = [[IMHomeDeviceViewController alloc] initWithNibName:@"IMHomeDeviceViewController" bundle:nil];
                    [self.homeNavigationController pushViewController:objVC animated:YES];
                }
            }
                break;
                
            case 1:{
                BOOL isControllerFound = NO;
                NSArray *viewControllerArray = [self.homeNavigationController viewControllers];
                for (UIViewController *viewControllerObj in viewControllerArray) {
                    if([viewControllerObj isKindOfClass:[IMStaticViewController class]]) {
                        [self.homeNavigationController popToViewController:viewControllerObj animated:YES];
                        isControllerFound = YES;
                        break;
                    }
                }
                if(!isControllerFound) {
                    IMStaticViewController *objVC = [[IMStaticViewController alloc] initWithNibName:@"IMStaticViewController" bundle:nil];
                    [self.homeNavigationController pushViewController:objVC animated:YES];
                }
            }
                break;
                
            case 2:{
                BOOL isControllerFound = NO;
                NSArray *viewControllerArray = [self.homeNavigationController viewControllers];
                for (UIViewController *viewControllerObj in viewControllerArray) {
                    if([viewControllerObj isKindOfClass:[IMEnquiryViewController class]]) {
                        [self.homeNavigationController popToViewController:viewControllerObj animated:YES];
                        isControllerFound = YES;
                        break;
                    }
                }
                if(!isControllerFound) {
                    IMEnquiryViewController *objVC = [[IMEnquiryViewController alloc] initWithNibName:@"IMEnquiryViewController" bundle:nil];
                    [self.homeNavigationController pushViewController:objVC animated:YES];
                }
            }
                break;
                
            case 3:{
                // Refer a friend
                NSString * message = @"We are doint IOT Application.";
                // UIImage * image = [UIImage imageNamed:@"boyOnBeach"];
                NSArray * shareItems = @[message];
                UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
                [self presentViewController:avc animated:YES completion:nil];
                
            }
                break;
            case 4:{
                // Sync Device Model Status
                BOOL isControllerFound = NO;
                NSArray *viewControllerArray = [self.homeNavigationController viewControllers];
                for (UIViewController *viewControllerObj in viewControllerArray) {
                    if([viewControllerObj isKindOfClass:[IMSynchDeviceModelViewController class]]) {
                        [self.homeNavigationController popToViewController:viewControllerObj animated:YES];
                        isControllerFound = YES;
                        break;
                    }
                }
                if(!isControllerFound) {
                    IMSynchDeviceModelViewController *objVC = [[IMSynchDeviceModelViewController alloc] initWithNibName:@"IMSynchDeviceModelViewController" bundle:nil];
                    [self.homeNavigationController pushViewController:objVC animated:YES];
                }
                
            }
                break;
                
            case 5:{
                // Device model
                [IMAppUtility alertWithTitle:BLANK andMessage:WORKING_PROGRESS andController:self];
                
            }
                break;
                
            case 6:{
                BOOL isControllerFound = NO;
                NSArray *viewControllerArray = [self.homeNavigationController viewControllers];
                for (UIViewController *viewControllerObj in viewControllerArray) {
                    if([viewControllerObj isKindOfClass:[IMCustomerSupportViewController class]]) {
                        [self.homeNavigationController popToViewController:viewControllerObj animated:YES];
                        isControllerFound = YES;
                        break;
                    }
                }
                if(!isControllerFound) {
                    IMCustomerSupportViewController *objVC = [[IMCustomerSupportViewController alloc]initWithNibName:@"IMCustomerSupportViewController" bundle:nil];
                    [self.homeNavigationController pushViewController:objVC animated:YES];
                }
            }
                break;
                
            case 7:{
                
                IMLogoutViewController *objVC = [[IMLogoutViewController alloc] initWithNibName:@"IMLogoutViewController" bundle:nil];
                objVC.delegate = self;
                objVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self.navigationController presentViewController:objVC animated:NO completion:nil];
            }
                break;
            default:
                break;
        }
    }
                    dismissBlock:^{
                    }];

}

/**
 Back Delegate method from Logout Screen
 
 @param popUpType type of Pop Up shown basically
 1: Logout
 2: Home
 3: Away
 4: Stay
 */
- (void)logOutButtonDelegateWithPopUpType:(NSInteger)popUpType {
    
    switch (popUpType) {
        case 1:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        default:
            break;
    }
    
}


@end
