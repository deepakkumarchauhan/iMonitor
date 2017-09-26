//
//  IMTextField.h
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/7/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMTextField : UITextField

@property (nonatomic, setter=setPaddingValue:) IBInspectable NSInteger paddingValue;
@property (nonatomic, strong) IBInspectable UIImage *paddingIcon;

@property (strong, nonatomic) NSIndexPath *indexPath; // use if cell for getting easily the cell & txtfield

- (void)placeHolderText:(NSString *)text;
- (void)placeHolderTextWithColor:(NSString *)text :(UIColor *)color;
- (void)setPlaceholderImage:(UIImage *)iconImage;
- (void)error:(BOOL)status;

@end
