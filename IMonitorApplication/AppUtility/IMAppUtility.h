//
//  IMAppUtility.h
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/7/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// To Set Home as room or appliance
typedef enum : NSUInteger {
    isRoom,
    isAppliance
} deviceType;


@interface IMAppUtility : NSObject

UIColor *getColor(float r,float g,float b,float a);

+(void)alertWithTitle : (NSString*)title andMessage:(NSString*)message andController:(id)controller;

+(UIBarButtonItem *) rightBarButton:(id)controller andImageName:(NSString*) imageName;
+(UIBarButtonItem *) leftBarButton:(id)controller andImageName:(NSString*) imageName;

+(UIBarButtonItem *) rightBarButtonTitle:(id)controller andTitle:(NSString*) title;

+(UIBarButtonItem *) leftBarButtonTitle:(id)controller andTitle:(NSString*) title;

UIToolbar* toolBarForNumberPad(id controller, NSString *titleDoneOrNext);

void setCornerForView(UIView *view, UIColor *borderColor, CGFloat borderWidth, CGFloat cornerRadius);
+(NSAttributedString*)getAttributeString:(NSString*)wholeString colorRange:(NSRange)colorRange;

+ (void)addGradientOnButtonWithStartColor:(UIColor *)startColor mediumColor:(UIColor *)mediumColor andEndColor:(UIColor *)endColor forButton:(UIButton *)customButton andTitle:(NSString *)buttonTitle;

//- (void) rightBarBtnAction:(UIButton *)sender;
//- (void) leftBarBtnAction:(UIButton *)sender;
//
//+(NSString*)getJSONFromDict:(NSDictionary*)dict;
//+(NSString *)getHoursAgo:(NSString*)timestamp;
//+ (NSString *) getDateFromTimestamp:(NSString *)timestamp;
//+ (NSString *)getStringDateFromTimestamp:(NSString *)timestamp;
//+ (NSString *)getCurrentDate;

@end
