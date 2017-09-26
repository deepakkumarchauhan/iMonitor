//
//  NSString+IMValidation.m
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 07/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "NSString+IMValidation.h"

@implementation NSString (IMValidation)

#pragma mark - email validation method

-(BOOL)validatePhoneNumber{
    
    NSString *mobileNumberPattern = @"[123456789][0-9]{9}";
    NSPredicate *mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
    if ([mobileNumberPred evaluateWithObject:self])
        return NO;
    else
        return YES;
}

-(BOOL)validateFirstName {
    
    NSString *exprs =@"^[a-zA-Z]+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", exprs];
    if ([emailTest evaluateWithObject:self]) {
        return NO;
    }
    else{
        return YES;
    }
}


-(BOOL)validateFirstNameWithSpace{
    
    NSString *stricterFilterString = @"^[a-zA-Z\\s]+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    if ([emailTest evaluateWithObject:self]) {
        return NO;
    }
    else{
        return YES;
    }
    
}

-(BOOL)validateNameWithSpace{
    
    NSString *stricterFilterString = @"^[a-zA-Z\\s]+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    if ([emailTest evaluateWithObject:self]) {
        return NO;
    }
    else{
        return YES;
    }
}

-(BOOL)validateUserNameWithSpace{
    
    NSString *stricterFilterString = @"^[a-zA-Z0-9]+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    if ([emailTest evaluateWithObject:self]) {
        return NO;
    }
    else{
        return YES;
    }
}


-(BOOL)validateEmailWithString{
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    if ([emailTest evaluateWithObject:self]) {
        return NO;
    }
    else{
        return YES;
    }
}


@end
