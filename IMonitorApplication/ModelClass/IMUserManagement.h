//
//  IMUserManagement.h
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/7/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMUserManagement : NSObject

@property (strong, nonatomic) NSString *stringUserName;
@property (strong, nonatomic) NSString *stringCustomerID;
@property (strong, nonatomic) NSString *stringPassword;
@property (assign, nonatomic) BOOL isInternetSelected;
@property (assign, nonatomic) BOOL isRememberMeMarked;
@property (strong, nonatomic) NSString *stringSelectedServer;
@property (nonatomic,strong) NSString *emailID;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *enquiry;

@property (nonatomic,strong) NSString *tempPassword;
@property (nonatomic,strong) NSString *changePassword;
@property (nonatomic,strong) NSString *confirmPassword;

@end
