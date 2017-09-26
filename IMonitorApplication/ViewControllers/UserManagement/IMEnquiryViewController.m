//
//  IMEnquiryViewController.m
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 07/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMEnquiryViewController.h"
#import "IMAppUtility.h"
#import "IMUserManagement.h"
#import "NSString+IMValidation.h"
#import "IMEnquiryTableViewCell.h"
#import "IMEnquiryContentTableViewCell.h"
#import "IMEnquiryAlertViewController.h"
#import "Macro.h"

static NSString *cellIdentifier = @"enquiryCellID";
static NSString *cellContentIdentifier = @"enquiryContentCellID";


@interface IMEnquiryViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate> {
    IMUserManagement *userInfo;

}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation IMEnquiryViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:@"IMEnquiryContentTableViewCell" bundle:nil] forCellReuseIdentifier:cellContentIdentifier];
    
    self.tableView.alwaysBounceVertical = NO;
    
    // Alloc Model Class
    userInfo = [[IMUserManagement alloc] init];
}

-(BOOL)validationMethod {
    
    if (!userInfo.stringUserName.length) {
        [IMAppUtility alertWithTitle:BLANK andMessage:BLANK_NAME andController:self];
    }
    else if (userInfo.stringUserName.length < 2) {
        [IMAppUtility alertWithTitle:BLANK andMessage:LENGTH_NAME andController:self];
    }
    else if (!userInfo.emailID.length) {
        [IMAppUtility alertWithTitle:BLANK andMessage:BLANK_EMAIL andController:self];
    }
    else if ([userInfo.emailID validateEmailWithString]) {
        [IMAppUtility alertWithTitle:BLANK andMessage:VALIDATE_EMAIL andController:self];
    }
    else if (!userInfo.phone.length) {
        [IMAppUtility alertWithTitle:BLANK andMessage:BLANK_PHONE andController:self];
    }
    else if ([userInfo.phone validatePhoneNumber]) {
        [IMAppUtility alertWithTitle:BLANK andMessage:VALIDATE_PHONE andController:self];
    }
    else if (!userInfo.enquiry.length) {
        [IMAppUtility alertWithTitle:BLANK andMessage:BLANK_ENQUIRY andController:self];
    }
    else if (userInfo.enquiry.length < 2) {
        [IMAppUtility alertWithTitle:BLANK andMessage:LENGTH_ENQUIRY andController:self];
    }
    else {
        return YES;
    }
    return NO;
}


#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IMEnquiryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    IMEnquiryContentTableViewCell *contentCell = [self.tableView dequeueReusableCellWithIdentifier:cellContentIdentifier];
    
    cell.enquiryTextField.delegate = self;
    contentCell.enquiryTextView.delegate = self;
    
    cell.enquiryTextField.tag = indexPath.row + 100;
    contentCell.enquiryTextView.tag = indexPath.row + 100;
    cell.enquiryTextField.returnKeyType = UIReturnKeyNext;

    switch (indexPath.row) {
        case 0:
            [cell.enquiryTextField placeHolderTextWithColor:@"Name" :RGBCOLOR(179, 180, 180, 1)];
            cell.enquiryTextField.text = userInfo.stringUserName;
            cell.enquiryTextField.keyboardType = UIKeyboardTypeDefault;
            break;
            
        case 1:
            [cell.enquiryTextField placeHolderTextWithColor:@"Email" :RGBCOLOR(179, 180, 180, 1)];
            cell.enquiryTextField.text = userInfo.emailID;
            cell.enquiryTextField.keyboardType = UIKeyboardTypeEmailAddress;
            break;
            
        case 2:
            [cell.enquiryTextField placeHolderTextWithColor:@"Phone" :RGBCOLOR(179, 180, 180, 1)];
            cell.enquiryTextField.text = userInfo.phone;
            cell.enquiryTextField.returnKeyType = UIReturnKeyDone;
            cell.enquiryTextField.keyboardType = UIKeyboardTypePhonePad;
            break;
            
        case 3:
            contentCell.enquiryTextView.placeholder = @"Enquiry";
            contentCell.enquiryTextView.text = userInfo.enquiry;
            return contentCell;
            
        default:
            break;
    }
    return cell;
}


#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3) {
        return 150;
    }
    return 60;
}

#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 102) {
        textField.inputAccessoryView = toolBarForNumberPad(self, @"Done");
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    switch (textField.tag) {
        case 100:
            userInfo.stringUserName = textField.text;
            break;
        case 101:
            userInfo.emailID = textField.text;
            break;
        case 102:
            userInfo.phone = textField.text;
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
    if (str.length > 50 && textField.tag == 100)
        return NO;
    else if ([str validateNameWithSpace] && textField.tag == 100)
        return NO;
    else if (str.length > 100 && textField.tag == 101)
        return NO;
    else if (str.length > 20 && textField.tag == 102)
        return NO;
    
    return YES;
}


#pragma mark - UITextView Delegate
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    userInfo.enquiry = textView.text;
}

#pragma mark - Custome Delegate Method
-(void)doneWithNumberPad {
    
    [self.view endEditing:YES];
}

#pragma mark - UIButton Action
- (IBAction)backButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonAction:(id)sender {
    
    [self.view endEditing:YES];
    if ([self validationMethod]) {
        
        IMEnquiryAlertViewController *objVC = [[IMEnquiryAlertViewController alloc] initWithNibName:@"IMEnquiryAlertViewController" bundle:nil];
        objVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:objVC animated:NO completion:nil];
   
    }
}


#pragma mark - UIMemory Management Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
