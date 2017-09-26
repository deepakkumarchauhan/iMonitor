//
//  NSString+IMValidation.h
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 07/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IMValidation)

-(BOOL)validateEmailWithString;
-(BOOL)validatePhoneNumber;
//-(BOOL)containsOnlyNumbersAndDot;
-(BOOL)validateFirstName;
-(BOOL)validateFirstNameWithSpace;
-(BOOL)validateNameWithSpace;
-(BOOL)validateUserNameWithSpace;
@end
