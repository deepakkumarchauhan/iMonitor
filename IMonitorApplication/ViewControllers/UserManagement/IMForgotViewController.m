//
//  IMForgotViewController.m
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 07/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMForgotViewController.h"
#import "IMAppUtility.h"
#import "IMUserManagement.h"
#import "NSString+IMValidation.h"
#import "IMRequestResponseHandler.h"
#import "IMSoapEnvelope.h"
#import "Macro.h"
#import "AESCrypto.h"
#import "IMAppConstants.h"

@interface IMForgotViewController ()<RequestResponseHandlerDelegate,UITextFieldDelegate> {
    IMUserManagement *userInfo;
}
@property (strong, nonatomic) IBOutlet UITextField *custermIDTextField;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;

@end

@implementation IMForgotViewController

#pragma mark - UIView Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Call Initial Method
    [self initialMethod];
}

#pragma mark - Custom Method
-(void)initialMethod {
    
    self.custermIDTextField.layer.borderWidth = 1.0;
    self.custermIDTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.usernameTextField.layer.borderWidth = 1.0;
    self.usernameTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _imageTopConstraint.constant = 27.0;
    
    // Alloc Model Class
    userInfo = [[IMUserManagement alloc] init];
    [IMAppUtility addGradientOnButtonWithStartColor:RGBCOLOR(139, 215, 247, 1) mediumColor:RGBCOLOR(65, 176, 231, 1) andEndColor:RGBCOLOR(139, 215, 247, 1) forButton:self.submitButton andTitle:@"SUBMIT"];
    setCornerForView(self.submitButton, RGBCOLOR(139, 215, 247, 1), 2, 15);

}

-(BOOL)validationMethod {
    
    if (!userInfo.stringCustomerID.length) {
        [IMAppUtility alertWithTitle:@"Error!" andMessage:@"Please enter customer ID." andController:self];
    }
    else if (!userInfo.stringUserName.length) {
        [IMAppUtility alertWithTitle:@"Error!" andMessage:@"Please enter username." andController:self];
    }
    else if (userInfo.stringUserName.length < 2) {
        [IMAppUtility alertWithTitle:@"Error!" andMessage:@"Username must be of atleast 2 characters." andController:self];
    }
    else {
        return YES;
    }
    
    return NO;
}

#pragma mark - UITextField Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 100)
        userInfo.stringCustomerID = TRIM_SPACE(textField.text);
    else {
        userInfo.stringUserName = TRIM_SPACE(textField.text);
        
        if (windowWidth <= 320) {
            [UIView animateWithDuration:0.3 animations:^{
                self.imageTopConstraint.constant = 27.0;
                [self.view layoutIfNeeded];
            }];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 101) {
        if (windowWidth <= 320) {
            [UIView animateWithDuration:0.3 animations:^{
                self.imageTopConstraint.constant = -35.0;
                [self.view layoutIfNeeded];
            }];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
 
    if (textField.tag == 100) {
        UITextField *txtField = [self.view viewWithTag:textField.tag+1];
        [txtField becomeFirstResponder];
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;
    }
    if (str.length > 100)
        return NO;
    
    if (textField.tag == 101 && [str validateUserNameWithSpace])
        return NO;

    return YES;
}


#pragma mark - UIButton Action
- (IBAction)submitButtonAction:(id)sender {
    
    [self.view endEditing:YES];
    if ([self validationMethod]) {
        
        NSMutableDictionary *dictParams = [NSMutableDictionary dictionary];
        [dictParams setValue:userInfo.stringCustomerID forKey:@"customerid"];
        [dictParams setValue:userInfo.stringUserName forKey:@"userid"];

        [self makeWebAPICallMethodCalling:[IMSoapEnvelope forgotWithDictionary:dictParams]];
    }
}

- (IBAction)backButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - * * * * Webservices Calling * * * *

-(void)makeWebAPICallMethodCalling:(NSString *)soapContent {
    
    IMRequestResponseHandler  *objHandler = [[IMRequestResponseHandler alloc] init];
    objHandler.delegate = self;
    [objHandler call_SOAP_POSTMethodWithRequest:soapContent andMethodName:forgotPassword andController:self];
}

#pragma mark - * * * * RequestResponseHandlerDelegate * * * *
-(void)ResponseContentFromServer:(IMRequestResponseHandler *)responseObj withData:(id)jsonData forMethod:(WebMethodType)methodType {
    
    if ([responseObj.responseCode intValue] == SERVER_RESPONSE_SUCCESS_CODE) {
       
        
        
    }
    else {
        [IMAppUtility alertWithTitle:@"Error!" andMessage:responseObj.responseMessage andController:self];
    }
}

#pragma mark - UIMemory Management Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
