//
//  IMLoginViewController.m
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/7/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMLoginViewController.h"
#import "IMLoginTableCell.h"
#import "Macro.h"
#import "IMUserManagement.h"
#import "VSDropdown.h"
#import "IMAppUtility.h"
#import "IMLabelClass.h"
#import "IMForgotViewController.h"
#import "IMHomeViewController.h"
#import "KeychainWrapper.h"
#import "IMAppConstants.h"
#import "AESCrypto.h"
#import <QuartzCore/QuartzCore.h>
#import "IMRequestResponseHandler.h"
#import "IMSoapEnvelope.h"

@interface IMLoginViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, VSDropdownDelegate,RequestResponseHandlerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *loginTableView;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;
@property (strong, nonatomic) IBOutlet UIView *tableFooterView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintServerButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintServerLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonServer;
@property (weak, nonatomic) IBOutlet IMLabelClass *selectedServerLabel;
@property (weak, nonatomic) IBOutlet UIButton *internetButton;
@property (weak, nonatomic) IBOutlet UIButton *localButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *rememberMeButton;

@property (strong, nonatomic) IMUserManagement *userObj;
@property (strong, nonatomic) VSDropdown *dropDownList;

@end


@implementation IMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpIntialLoadingLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [IMAppUtility addGradientOnButtonWithStartColor:RGBCOLOR(139, 215, 247, 1) mediumColor:RGBCOLOR(65, 176, 231, 1) andEndColor:RGBCOLOR(139, 215, 247, 1) forButton:self.submitButton andTitle:@"SUBMIT"];
    setCornerForView(self.submitButton, RGBCOLOR(139, 215, 247, 1), 2, 15);
    

}

#pragma mark -********************** Helper Methods ********************-
- (void)setUpIntialLoadingLogin {
    
    [self.loginTableView registerNib:[UINib nibWithNibName:@"IMLoginTableCell" bundle:nil] forCellReuseIdentifier:@"IMLoginTableCell"];
    
    //Adding header and footer for table
    self.loginTableView.tableFooterView = self.tableFooterView;
    self.loginTableView.tableHeaderView = self.tableHeaderView;
    
    self.buttonServer.layer.borderColor = RGBCOLOR(180, 180, 180, 1).CGColor;
    self.buttonServer.layer.borderWidth = 1.0;

    //Modal Class Allocation
    self.userObj = [[IMUserManagement alloc]init];
    
    self.dropDownList = [[VSDropdown alloc]initWithDelegate:self];
    [self.dropDownList setAdoptParentTheme:YES];
    setCornerForView(self.dropDownList, RGBCOLOR(180, 180, 180, 1), 1.0, 2.0);
    [self.internetButton setSelected:YES];
    [self getSavedKeychainDataInCaseOfRememberMe];
    

}


/**
 Access saved values from KeyChain
 */
- (void)getSavedKeychainDataInCaseOfRememberMe {
    
    NSString *strCustomerID = [AESCrypto AES128DecryptString:[NSString stringWithFormat:@"%@",[NSUSERDEFAULT valueForKey:kCustomerID]] withKey:kEncryptionKey];
    NSString *strUserName = [AESCrypto AES128DecryptString:[NSString stringWithFormat:@"%@",[NSUSERDEFAULT valueForKey:kUserName]] withKey:kEncryptionKey];
    NSString *strPassword =[AESCrypto AES128DecryptString:[NSString stringWithFormat:@"%@",[NSUSERDEFAULT valueForKey:kPassword]] withKey:kEncryptionKey];
    NSString *strIsRemember = [NSUSERDEFAULT valueForKey:kIsRememberMeYes];
    self.userObj.stringCustomerID = strCustomerID;
    self.userObj.stringUserName = strUserName;
    self.userObj.stringPassword= strPassword;
    if([strIsRemember isEqualToString:@"yes"]) {
        [self.rememberMeButton setSelected:YES];
        self.userObj.isRememberMeMarked = YES;
    }
    [self.loginTableView reloadData];
}

/**
 Validate the input field on submit button

 @return validation result
 */
- (BOOL)isInputValuesAreValid {
    
    BOOL isValid = NO;
    if(!self.userObj.stringCustomerID.length) {
       [IMAppUtility alertWithTitle:@"Error!" andMessage:@"Please enter customer id." andController:self];
    }
   else if(!self.userObj.stringUserName.length) {
        [IMAppUtility alertWithTitle:@"Error!" andMessage:@"Please enter username." andController:self];
    }
   else if(!self.userObj.stringPassword.length) {
       [IMAppUtility alertWithTitle:@"Error!" andMessage:@"Please enter password." andController:self];
   }
   else if(self.userObj.stringPassword.length < 8) {
       [IMAppUtility alertWithTitle:@"Error!" andMessage:@"Please enter valid password. Password should be minimum 8 digits." andController:self];
   }
   else {
       if(self.userObj.isRememberMeMarked) {
           [NSUSERDEFAULT setValue: [AESCrypto AES128EncryptString:self.userObj.stringCustomerID withKey:kEncryptionKey]  forKey:kCustomerID];
           [NSUSERDEFAULT setValue:[AESCrypto AES128EncryptString:self.userObj.stringUserName withKey:kEncryptionKey] forKey:kUserName];
           [NSUSERDEFAULT setValue:[AESCrypto AES128EncryptString:self.userObj.stringPassword withKey:kEncryptionKey] forKey:kPassword];
           [NSUSERDEFAULT setValue:@"yes" forKey:kIsRememberMeYes];
           [NSUSERDEFAULT synchronize];
       }
    
//       KeychainWrapper *keyChainWrapper = [[KeychainWrapper alloc]init];
//       if(self.userObj.isRememberMeMarked) {
//           [keyChainWrapper mySetObject:self.userObj.stringCustomerID forKey:(__bridge id)kSecAttrAccount];
//           [keyChainWrapper mySetObject:self.userObj.stringUserName forKey:kUserName];
//           [keyChainWrapper mySetObject:self.userObj.stringPassword forKey:kPassword];
//           [keyChainWrapper mySetObject:@"yes" forKey:kIsRememberMeYes];
//           [keyChainWrapper writeToKeychain];
//       }
//       else {
//           [keyChainWrapper mySetObject:@"no" forKey:kIsRememberMeYes];
//           [keyChainWrapper writeToKeychain];
//       }
       isValid = YES;
   }
    return isValid;
}

#pragma mark -********************* UITableViewDataSource Methods *****************-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IMLoginTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMLoginTableCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.loginCellTextField.delegate = self;
    cell.loginCellTextField.tag = indexPath.row;
    switch (indexPath.row) {
        case 0:{
            cell.loginCellTextField.returnKeyType = UIReturnKeyNext;
            [cell.loginCellTextField placeHolderTextWithColor:@"Enter Customer ID" :RGBCOLOR(179, 180, 180, 1)];
            if(self.userObj.stringCustomerID.length) {
                [cell.loginCellTextField setText:self.userObj.stringCustomerID];
            }
        }
            break;
        case 1:{
            cell.loginCellTextField.returnKeyType = UIReturnKeyNext;
            [cell.loginCellTextField placeHolderTextWithColor:@"Enter Username" :RGBCOLOR(179, 180, 180, 1)];
            if(self.userObj.stringUserName.length) {
                [cell.loginCellTextField setText:self.userObj.stringUserName];
            }

        }
            break;
        case 2: {
            cell.loginCellTextField.secureTextEntry = YES;
            cell.loginCellTextField.returnKeyType = UIReturnKeyDone;
            [cell.loginCellTextField placeHolderTextWithColor:@"Enter Password" :RGBCOLOR(179, 180, 180, 1)];
            if(self.userObj.stringPassword.length) {
                [cell.loginCellTextField setText:self.userObj.stringPassword];
            }
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark -********************** TableViewDelegate Methods ***********************-
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

#pragma mark -*********************** TextFieldDelegate Methods ****************************-
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    UIResponder *responderObj = ViewWithTag(textField.tag+1);
    if(textField.returnKeyType == UIReturnKeyNext)
        [responderObj becomeFirstResponder];
    else
        [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage])
        return NO;
    
    NSString *completeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    switch (textField.tag) {
        case 0:
            self.userObj.stringCustomerID = TRIM_SPACE(completeString);
            return (completeString.length >= 40 && range.length == 0) ? NO : YES;
            break;
        case 1:
            self.userObj.stringUserName =  TRIM_SPACE(completeString);
            return (completeString.length >= 40 && range.length == 0) ? NO : YES;
            break;
        case 2:
            self.userObj.stringPassword =  TRIM_SPACE(completeString);
            return (completeString.length >= 16 && range.length == 0) ? NO : YES;
            break;
        default:
            return NO;
            break;
    }
    
}

#pragma mark -*********************** Button Action & Selector Methods *********************-
- (IBAction)commonButtonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 91: {
            //Internet
            self.userObj.isInternetSelected = YES;
            self.heightConstraintServerButton.constant = 41.0;
            self.heightConstraintServerLabel.constant = 41.0;
            [self.selectedServerLabel setHidden:NO];
            [self.buttonServer setHidden:NO];
            [self.internetButton setSelected:YES];
            [self.localButton setSelected:NO];
        }
            break;
        case 92: {
            //Local
            self.userObj.isInternetSelected = NO;
            self.heightConstraintServerButton.constant = 0.0;
            self.heightConstraintServerLabel.constant = 0.0;
            [self.selectedServerLabel setHidden:YES];
            [self.buttonServer setHidden:YES];
            [self.internetButton setSelected:NO];
            [self.localButton setSelected:YES];
        }
            break;
        case 93: {
            //Server (myhomeeqi.com)
            [self showDropDownForButton:self.buttonServer adContents:[NSArray arrayWithObjects:@"myhomeeqi.com",@"eurovigilmonitor.com", nil] multipleSelection:NO];
        }
            break;
        case 94: {
            sender.selected = !sender.selected;
            self.userObj.isRememberMeMarked =  !self.userObj.isRememberMeMarked;
        }
            break;
        case 95: {
            //Forgot Password
            IMForgotViewController *forgotPasswordVC = [[IMForgotViewController alloc]initWithNibName:@"IMForgotViewController" bundle:nil];
            [self.navigationController pushViewController:forgotPasswordVC animated:YES];
        }
            break;
        case 96: {
            //Submit
            if([self isInputValuesAreValid]) {
                
                NSMutableDictionary *dictParams = [NSMutableDictionary dictionary];
                [dictParams setValue:self.userObj.stringCustomerID forKey:@"customerid"];
                [dictParams setValue:self.userObj.stringUserName forKey:@"userid"];
                [dictParams setValue:self.userObj.stringPassword forKey:@"password"];
                [self makeWebAPICallMethodCalling:[IMSoapEnvelope loginUserWithDictionary:dictParams]];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - VSDropdown Delegate Methods
-(void)showDropDownForButton:(UIButton *)sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection {
    
    [self.dropDownList setDrodownAnimation:rand()%2];
    [self.dropDownList setAllowMultipleSelection:multipleSelection];
    [self.dropDownList setupDropdownForView:sender];
    [self.dropDownList setSeparatorColor:[UIColor darkGrayColor]];
    [self.dropDownList reloadDropdownWithContents:contents andSelectedItems:nil];
    
}
- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected {
    
    [self.selectedServerLabel setText:str];;
    [self.view endEditing:YES];
}

#pragma mark - * * * * Webservices Calling * * * *
-(void)makeWebAPICallMethodCalling:(NSString *)soapContent {
    
    IMRequestResponseHandler  *objHandler = [[IMRequestResponseHandler alloc] init];
    objHandler.delegate = self;
    [objHandler call_SOAP_POSTMethodWithRequest:soapContent andMethodName:loginUser andController:self];
}

#pragma mark - * * * * RequestResponseHandlerDelegate * * * *
-(void)ResponseContentFromServer:(IMRequestResponseHandler *)responseObj withData:(id)jsonData forMethod:(WebMethodType)methodType {
    
    if ([responseObj.responseCode intValue] == SERVER_RESPONSE_SUCCESS_CODE) {
        switch (methodType) {
            case loginUser:{
                IMHomeViewController *homeViewVC = [[IMHomeViewController alloc]initWithNibName:@"IMHomeViewController" bundle:nil];
                [self.navigationController pushViewController:homeViewVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    else {
        [IMAppUtility alertWithTitle:@"Error!" andMessage:responseObj.responseMessage andController:self];
    }
}

@end
