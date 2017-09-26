//
//  IMCustomerSupportViewController.m
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 08/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMCustomerSupportViewController.h"
#import "IMAppUtility.h"

@interface IMCustomerSupportViewController ()
@property (strong, nonatomic) IBOutlet UILabel *supportLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation IMCustomerSupportViewController


#pragma mark - UIView Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Call Initial Method
    [self initialMethod];
}

#pragma mark - Custom Method
-(void)initialMethod {
    
    self.supportLabel.attributedText = [IMAppUtility getAttributeString:@"CUSTOMER SUPPORT" colorRange:NSMakeRange(9, 7)];
    
}

#pragma mark - UIMemory Management Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
