//
//  IMRequestResponseHandler.m
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/15/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMRequestResponseHandler.h"
#import "Macro.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "XMLReader.h"
#import "NSDictionary+NullChecker.h"

@interface IMRequestResponseHandler()

@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) UIViewController *controllerClass;

@end

@implementation IMRequestResponseHandler

@synthesize responseMessage;
@synthesize responseCode;

@synthesize connectionObj;

- (id)init {
    
    self = [super init];
    if (self) {
        connectionObj = [[HttpConnectionManager alloc] init];
    }
    return self;
}

// Throw error when connection not established
-(void)downloadDidFailWithError:(NSError *)error {
    
    [self removeProgressHUDFromController:self.controllerClass];
    
    self.responseCode = _DEFAULT_REQUEST_CONNECTION_ERROR;
    self.responseMessage = (error ? [error localizedDescription] : @"Request timed out, please try again later.");
    if (self && self.delegate && [self.delegate respondsToSelector:@selector(ResponseContentFromServer:withData:forMethod:)])
        [self.delegate ResponseContentFromServer:self withData:nil forMethod:requestMethode];
}


-(NSDictionary*)getResponseFromRawResponseFromServer:(NSDictionary*)response forMethod:(WebMethodType)method {
    
    NSDictionary *responseData = nil;
    switch (requestMethode) {
        case loginUser:
            responseData = [[response objectForKey:@"GetUserProfileResponse"] objectForKey:@"GetUserProfileResult"];
            break;
        case forgotPassword:
            responseData = [[response objectForKey:@"GetUserProfileResponse"] objectForKey:@"GetUserProfileResult"];
            break;
        default:
            break;
    }
    
    return responseData;
}

// When connection finished and downloading finished
- (void)downloadDidFinishLoading:(HttpConnectionManager *)serverResponseInfo {
    
    [self removeProgressHUDFromController:self.controllerClass];
    
    NSDictionary *responseXMLData = [XMLReader dictionaryForXMLString:serverResponseInfo.responseString error:nil];
    NSDictionary *responseJSONData = [self getResponseFromRawResponseFromServer:[[responseXMLData objectForKey:_SOAP_ENVELOPE] objectForKey:_SOAP_BODY] forMethod:requestMethode];
    
    self.responseCode = [NSString stringWithFormat:@"%@",[[responseJSONData objectForKey:_RESPONSE_STATUS] getTextValueForKey:_STAUS_CODE]];
    self.responseMessage = [NSString stringWithFormat:@"%@",[[responseJSONData objectForKey:_RESPONSE_STATUS] getTextValueForKey:_STATUSDESCRIPTION]];
    
    if (!self.responseMessage || [self.responseMessage length] < 1 || [self.responseMessage isEqualToString:@"(null)"])
        self.responseMessage = @"Unknown error occurred!";
    
    if (self && self.delegate && [self.delegate respondsToSelector:@selector(ResponseContentFromServer:withData:forMethod:)])
        [self.delegate ResponseContentFromServer:self withData:responseJSONData forMethod:requestMethode];
}
-(void)call_SOAP_POSTMethodWithRequest:(NSString*)XMLRequest andMethodName:(WebMethodType)methodName andController:(UIViewController *)controller {
    
    if ([APPDELEGATE isReachable]) {
        
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        self.controllerClass = controller;
        if (self.controllerClass) {
            [MBProgressHUD hideAllHUDsForView:controller.view animated:NO];
            [self addProgressHUDToController:self.controllerClass];
        }
        
        requestMethode = methodName;
        connectionObj.delegate = self;
      //  http://www.imsserver.com:8080/imonitor/mobile/login.action
        NSString *urlToHit = [NSString stringWithFormat:@"%@%@",[NSUSERDEFAULT valueForKey:kSerivceBaseURL],[self getAPINameFromWebMethodType:methodName]];
        [connectionObj WebsewrviceAPICall:urlToHit webserviceBodyInfo:XMLRequest];
    }
    else {
        
        self.responseCode = _DEFAULT_REQUEST_CONNECTION_ERROR;
        self.responseMessage = NETWORK_UNREACHABLE_ERR;
        if (self && self.delegate && [self.delegate respondsToSelector:@selector(ResponseContentFromServer:withData:forMethod:)])
            [self.delegate ResponseContentFromServer:self withData:nil forMethod:requestMethode];
    }
}
#pragma mark - **** Progress HUD Helper ****
-(void)addProgressHUDToController :(UIViewController*)controller {
    
    [MBProgressHUD hideAllHUDsForView:controller.view animated:YES];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
    [self.progressHUD setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];
    [self.progressHUD setColor:[UIColor colorWithWhite:1.0 alpha:0.9]];
}

-(void)removeProgressHUDFromController:(UIViewController*)controller {
    //not hidding HUD in case of 'getHTMLReceiptForPrinting' method
    //handled from the controller class
    
    if (self.controllerClass)
        [MBProgressHUD hideAllHUDsForView:controller.view animated:YES];
    self.progressHUD = nil;
}

- (NSString *)getAPINameFromWebMethodType:(WebMethodType)methodType {
    
    NSString *strAPIName = @"";
    switch (methodType) {
        case loginUser:
            strAPIName = @"mobile/login.action";
            break;
         case forgotPassword:
            strAPIName = @"";
            break;
        default:
            break;
    }
    return strAPIName;
}

@end
