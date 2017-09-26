//
//  IMEnquiryAlertViewController.m
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 08/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMEnquiryAlertViewController.h"

@interface IMEnquiryAlertViewController ()
@property (strong, nonatomic) IBOutlet UIView *mainView;

@end

@implementation IMEnquiryAlertViewController


#pragma mark - UIView Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set mainView corner radius
    self.mainView.layer.cornerRadius = 12.0;
    self.mainView.layer.masksToBounds = YES;
}


#pragma mark - UIButton Action
- (IBAction)okButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UIMemory Management Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
