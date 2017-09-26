//
//  IMLogoutViewController.m
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 08/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMLogoutViewController.h"

@interface IMLogoutViewController ()
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;

@end

@implementation IMLogoutViewController

#pragma mark - UIView Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set mainView corner radius
    self.mainView.layer.cornerRadius = 12.0;
    self.mainView.layer.masksToBounds = YES;
    switch (self.typeOfPopUp) {
        case 1:
            [self.titleLabel setText:@"LOGOUT"];
            [self.descriptionLabel setText:@"Are you sure you want to logout?"];
            break;
        case 2:
            [self.titleLabel setText:@"HOME"];
            [self.descriptionLabel setText:@"Do you wish to change mode to HOME?"];
            break;
        case 3:
            [self.titleLabel setText:@"AWAY"];
            [self.descriptionLabel setText:@"Do you wish to change mode to AWAY?"];
            break;
        case 4:
            [self.titleLabel setText:@"STAY"];
            [self.descriptionLabel setText:@"Do you wish to change mode to STAY?"];
            break;
        default:
            break;
    }
}


#pragma mark - UIButton Action
- (IBAction)yesButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    if(self && self.delegate && [self.delegate respondsToSelector:@selector(logOutButtonDelegateWithPopUpType:)]) {
        [self.delegate logOutButtonDelegateWithPopUpType:self.typeOfPopUp];
    }
}

- (IBAction)noButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UIMemory Management Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
