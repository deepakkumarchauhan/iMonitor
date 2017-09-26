//
//  HttpConnectionManager.h
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/15/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HttpConnectionManager;
@protocol ConnectionManagerDelegate <NSObject>
@optional

- (void)downloadDidFinishLoading:(HttpConnectionManager *)serverResponseInfo;
- (void)downloadDidFailWithError:(NSError *)error;

@end

@interface HttpConnectionManager : NSObject {
    
    id                      delegate;
    NSMutableData           *receivedData;
    NSString                *responseString;
    NSURLConnection         *theConnection;
    NSTimer                 *connectionTimer;
}

@property (nonatomic, strong,readwrite) id<ConnectionManagerDelegate> delegate;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSString *responseString;
@property (nonatomic, retain) NSURLConnection *theConnection;
@property (nonatomic, retain) NSTimer *connectionTimer;

-(void)WebsewrviceAPICall:(NSString *)serviceURL  webserviceBodyInfo:(NSString *)bodyString;

@end
