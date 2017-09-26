//
//  Macro.h
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/7/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define NSUSERDEFAULT       [NSUserDefaults standardUserDefaults]
#define TRIM_SPACE(str)         [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
#define APPDELEGATE            (AppDelegate*)[UIApplication sharedApplication].delegate
#define windowWidth                 [UIScreen mainScreen].bounds.size.width
#define windowHeight                [UIScreen mainScreen].bounds.size.height
#define RGBCOLOR(r,g,b,a)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define AppFont(X)                    [UIFont fontWithName:@"Roboto-Regular" size:X]
#define AppFontBOLD(X)          [UIFont fontWithName:@"Roboto-Bold" size:X]
#define AppFontITALIC(X)          [UIFont fontWithName:@"Roboto-Italic" size:X]
#define AppFontLIGHT(X)          [UIFont fontWithName:@"Roboto-Light" size:X]
#define AppFontCONDENSED(X) [UIFont fontWithName:@"RobotoCondensed-Italic" size:X]
#define AppTextColor                 [UIColor colorWithRed:17/255.0f green:106/255.0f blue:152/255.0f alpha:1.0f]
#define ViewWithTag(X)   [self.view viewWithTag:(X)];

#define IMLog(frmt, ...)    if(LOG_LEVEL) NSLog((@"%s" frmt), __PRETTY_FUNCTION__, ## __VA_ARGS__);
#define LOG_LEVEL           1

/*
 SOAP API Integration Macros
 */
#define kSerivceBaseURL @"API_Base_URL"
#define kSerivceURL @"API_URL"

//#define _SERVICE_BASE_URL @"https://www.secureclub.net/poswebservices/PointOfSaleService.asmx"
#define NETWORK_UNREACHABLE_ERR @"Please check your internet connection"
#define _DEFAULT_REQUEST_CONNECTION_ERROR @"400"
#define SERVER_RESPONSE_TIMEOUT 90.0
#define SERVER_RESPONSE_SUCCESS_CODE 200
//#define REQUEST_CONTENT_TYPE @"text/xml; charset=utf-8"
#define REQUEST_CONTENT_TYPE @"application/x-www-form-urlencoded"
#define REQUEST_HTTP_METHODE_TYPE @"POST"
// Services request response parametr name
#define _SOAP_ENVELOPE @"soap:Envelope"
#define _SOAP_BODY @"soap:Body"
#define _RESPONSE_STATUS @"ResponseStatus"
#define _STAUS_CODE @"StatusCode"
#define _STATUSDESCRIPTION @"StatusDescription"



static NSString *BLANK                      =      @"";
static NSString *BLANK_NAME                 =      @"Please enter name.";
static NSString *LENGTH_NAME                =      @"Name must be of atleast 2 characters.";
static NSString *VALIDATE_NAME              =      @"Please enter valid name.";
static NSString *BLANK_EMAIL                =      @"Please enter email.";
static NSString *VALIDATE_EMAIL             =      @"Please enter valid email.";
static NSString *BLANK_PHONE                =      @"Please enter phone.";
static NSString *LENGTH_PHONE               =      @"Phone must be of atleast 7 digits.";
static NSString *VALIDATE_PHONE             =      @"Please enter valid phone.";
static NSString *BLANK_ENQUIRY              =      @"Please enter enquiry.";
static NSString *VALIDATE_ENQUIRY           =      @"Please enter valid enquiry.";
static NSString *LENGTH_ENQUIRY             =      @"Enquiry must be of atleast 2 characters.";

static NSString *BLANK_TEMP_PASSWORD        =      @"Please enter temp. password.";
static NSString *VALIDATE_TEMP_PASSWORD     =      @"Temp. password must be of atleast 8 characters.";
static NSString *BLANK_NEW_PASSWORD         =      @"Please enter new password.";
static NSString *VALIDATE_NEW_PASSWORD      =      @"New password must be of atleast 8 characters.";
static NSString *BLANK_CONFIRM_PASSWORD     =      @"Please enter confirm password.";
static NSString *VALIDATE_CONFIRM_PASSWORD  =      @"Confirm password must be of atleast 8 characters.";

static NSString *VALIDATE_NEW_CONFIRM_PASSWORD  =      @"New password and confirm new password does not match.";

static NSString *WORKING_PROGRESS           =      @"Work in progress.";


#endif /* Macro_h */

