//
//  IMResetPasswordViewController.m
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 08/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMResetPasswordViewController.h"
#import "IMUserManagement.h"
#import "IMAppUtility.h"
#import "NSString+IMValidation.h"
#import "IMEnquiryTableViewCell.h"
#import "Macro.h"

static NSString *cellIdentifier = @"enquiryCellID";

@interface IMResetPasswordViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate> {
    
    IMUserManagement *userInfo;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation IMResetPasswordViewController

#pragma mark - UIView Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Call Initial Method
    [self initialMethod];
}

#pragma mark - Custom Method
-(void)initialMethod {
    
    // Register TableView
    [self.tableView registerNib:[UINib nibWithNibName:@"IMEnquiryTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    self.tableView.alwaysBounceVertical = NO;
    
    // Alloc Model Class
    userInfo = [[IMUserManagement alloc] init];
}

-(BOOL)validationMethod {
    
    if (!userInfo.tempPassword.length) {
        [IMAppUtility alertWithTitle:BLANK andMessage:BLANK_TEMP_PASSWORD andController:self];
    }
    else if (userInfo.tempPassword.length < 8) {
        [IMAppUtility alertWithTitle:BLANK andMessage:VALIDATE_TEMP_PASSWORD andController:self];
    }
    else if (!userInfo.changePassword.length) {
        [IMAppUtility alertWithTitle:BLANK andMessage:BLANK_NEW_PASSWORD andController:self];
    }
    else if (userInfo.changePassword.length < 8) {
        [IMAppUtility alertWithTitle:BLANK andMessage:VALIDATE_NEW_PASSWORD andController:self];
    }
    else if (!userInfo.confirmPassword.length) {
        [IMAppUtility alertWithTitle:BLANK andMessage:BLANK_CONFIRM_PASSWORD andController:self];
    }
    else if (userInfo.confirmPassword.length < 8) {
        [IMAppUtility alertWithTitle:BLANK andMessage:VALIDATE_CONFIRM_PASSWORD andController:self];
    }
    else if (![userInfo.confirmPassword isEqualToString:userInfo.changePassword]) {
        [IMAppUtility alertWithTitle:BLANK andMessage:VALIDATE_NEW_CONFIRM_PASSWORD andController:self];
    }

    else {
        return YES;
    }
    return NO;
}


#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IMEnquiryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.enquiryTextField.delegate = self;
    
    cell.enquiryTextField.tag = indexPath.row + 100;
    cell.enquiryTextField.returnKeyType = UIReturnKeyNext;
    cell.enquiryTextField.secureTextEntry = YES;
    
    switch (indexPath.row) {
        case 0:
            [cell.enquiryTextField placeHolderTextWithColor:@"Enter Temp. Password" :RGBCOLOR(179, 180, 180, 1)];
            cell.enquiryTextField.text = userInfo.tempPassword;
            break;
            
        case 1:
            [cell.enquiryTextField placeHolderTextWithColor:@"Enter New Password" :RGBCOLOR(179, 180, 180, 1)];
            cell.enquiryTextField.text = userInfo.changePassword;
            break;
            
        case 2:
            [cell.enquiryTextField placeHolderTextWithColor:@"Confirm New Password" :RGBCOLOR(179, 180, 180, 1)];
            cell.enquiryTextField.text = userInfo.confirmPassword;
            cell.enquiryTextField.returnKeyType = UIReturnKeyDone;
            break;
            
        default:
            break;
    }
    return cell;
}


#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60;
}

#pragma mark - UITextField Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    switch (textField.tag) {
        case 100:
            userInfo.tempPassword = textField.text;
            break;
        case 101:
            userInfo.changePassword = textField.text;
            break;
        case 102:
            userInfo.confirmPassword = textField.text;
            break;
            
        default:
            break;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.returnKeyType == UIReturnKeyNext) {
        
        UITextField *txtField = [self.view viewWithTag:textField.tag+1];
        [txtField becomeFirstResponder];
    }
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage])
    {
        return NO;
    }
    if (str.length > 16)
        return NO;
    
    return YES;
}


#pragma mark - UIButton Action
- (IBAction)backButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonAction:(id)sender {
    
    [self.view endEditing:YES];
    if ([self validationMethod]) {
        [IMAppUtility alertWithTitle:BLANK andMessage:@"Success!" andController:self];
    }
}

#pragma mark - UIMemory Management Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
