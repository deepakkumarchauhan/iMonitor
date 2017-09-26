//
//  IMRequestResponseHandler.h
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/15/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpConnectionManager.h"

typedef enum WebMethodCall {
    loginUser = 0,
    forgotPassword,
} WebMethodType;

@class IMRequestResponseHandler;

@protocol RequestResponseHandlerDelegate <NSObject>

@optional
-(void)ResponseContentFromServer:(IMRequestResponseHandler *)responseObj withData:(id)jsonData forMethod:(WebMethodType)methodType;

@end

@interface IMRequestResponseHandler : NSObject<ConnectionManagerDelegate> {
    WebMethodType       requestMethode;
}

@property (nonatomic, strong, readwrite)id<RequestResponseHandlerDelegate> delegate;
@property (nonatomic, retain) NSString *responseCode;
@property (nonatomic, retain) NSString *responseMessage;
@property (nonatomic, retain) HttpConnectionManager *connectionObj;

//Methodes decleartions
-(void)call_SOAP_POSTMethodWithRequest:(NSString*)XMLRequest andMethodName:(WebMethodType)methodName andController:(UIViewController *)controller;

- (void)downloadDidFinishLoading:(HttpConnectionManager *)serverResponseInfo;

-(void)downloadDidFailWithError:(NSError *)error;

-(void)addProgressHUDToController :(UIViewController*)controller;
-(void)removeProgressHUDFromController:(UIViewController*)controller;

@end
