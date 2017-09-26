//
//  IMFavouriteViewController.m
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/13/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMFavouriteViewController.h"

@interface IMFavouriteViewController ()

@end

@implementation IMFavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
