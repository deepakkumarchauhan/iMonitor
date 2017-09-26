//
//  IMAppUtility.m
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/7/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMAppUtility.h"
#import "Macro.h"

@implementation IMAppUtility

/*>>>>>>>>>>>>>>>>>>>>>>>>>>>> Getting color <<<<<<<<<<<<<<<<<<<<<<<<*/
UIColor *getColor(float r,float g,float b,float a) {
    
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

/*>>>>>>>>>>>>>>>>>>>>>>>>>>>> Setting corner for UIView <<<<<<<<<<<<<<<<<<<<<<<<*/
void setCornerForView(UIView *view, UIColor *borderColor, CGFloat borderWidth, CGFloat cornerRadius) {
    
    view.layer.cornerRadius =  cornerRadius;
    view.layer.borderColor = [borderColor CGColor];
    view.layer.borderWidth = borderWidth;
    view.clipsToBounds = YES;
}

+(void)alertWithTitle : (NSString*)title andMessage:(NSString*)message andController:(id)controller{
    UIAlertController   *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }];
    
    [alert addAction:defaultAction];
    [controller presentViewController:alert animated:NO completion:nil];
}


+(UIBarButtonItem *) rightBarButtonTitle:(id)controller andTitle:(NSString*)rightTitle {
    //NSString *str = [NSString stringWithFormat:title,nil];
    NSString *str = rightTitle;
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [aButton setTitle:str forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    aButton.frame = CGRectMake(0.0, 0.0, 50,25 );
    [aButton  addTarget:controller action:@selector(rightBarBtnAction:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:aButton];
    return aBarButtonItem;
    
}
+(UIBarButtonItem *) leftBarButtonTitle:(id)controller andTitle:(NSString *)leftTitle {
    NSString *string = leftTitle;
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [leftButton setTitle:string forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0.0, 0.0,50,25);
    [leftButton  addTarget:controller action:@selector(leftBarBtnAction:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    return aBarButtonItem;
}

+(UIBarButtonItem *) rightBarButton:(id)controller andImageName:(NSString*) imageName{
    UIImage *buttonImage = [UIImage imageNamed:imageName];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [aButton setImage:buttonImage forState:UIControlStateNormal];
    aButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width,buttonImage.size.height );
    [aButton  addTarget:controller action:@selector(rightBarBtnAction:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:aButton];
    return aBarButtonItem;
}


-(void) rightBarBtnAction:(UIButton *)sender{
    
}

+(UIBarButtonItem *) leftBarButton:(id)controller andImageName:(NSString*) imageName{
    UIImage *buttonImage = [UIImage imageNamed:imageName];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [aButton setImage:buttonImage forState:UIControlStateNormal];
    aButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width,buttonImage.size.height );
    [aButton  addTarget:controller action:@selector(leftBarBtnAction:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:aButton];
    return aBarButtonItem;
}

-(void) leftBarBtnAction:(UIButton *)sender{
    
}


UIToolbar* toolBarForNumberPad(id controller, NSString *titleDoneOrNext){
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, windowWidth, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    
    numberToolbar.items = [NSArray arrayWithObjects:
                           
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           
                           [[UIBarButtonItem alloc]initWithTitle:titleDoneOrNext style:UIBarButtonItemStyleDone target:controller action:@selector(doneWithNumberPad)],nil];
    
    numberToolbar.barTintColor = [UIColor whiteColor];
    
    [numberToolbar sizeToFit];
    
    return numberToolbar;
}

-(void)doneWithNumberPad {
    
}


+(NSAttributedString*)getAttributeString:(NSString*)wholeString colorRange:(NSRange)colorRange {
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:wholeString];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:128.0/250.0 green:208.0/255.0 blue:248.0/255.0 alpha:1.0] range:colorRange];
    
    return string;
    
}

+(NSString*)getJSONFromDict:(NSDictionary*)dict{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (! jsonData) {
        return @"";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+ (void)addGradientOnButtonWithStartColor:(UIColor *)startColor mediumColor:(UIColor *)mediumColor andEndColor:(UIColor *)endColor forButton:(UIButton *)customButton andTitle:(NSString *)buttonTitle{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = customButton.layer.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)startColor.CGColor,
                            (id)mediumColor.CGColor,
                             (id)endColor.CGColor,
                            nil];
    
    gradientLayer.locations = nil;
    gradientLayer.masksToBounds = YES;
    gradientLayer.cornerRadius = customButton.layer.cornerRadius;
    [customButton.layer insertSublayer:gradientLayer below:customButton.titleLabel.layer];
    
    
    [customButton setTitle:buttonTitle forState:UIControlStateNormal];
    [customButton setTitle:buttonTitle forState:UIControlStateSelected];

}

@end
