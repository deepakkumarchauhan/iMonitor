//
//  HttpConnectionManager.m
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/15/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "HttpConnectionManager.h"
#import "Macro.h"

@implementation HttpConnectionManager

@synthesize delegate;
@synthesize receivedData;
@synthesize responseString;
@synthesize theConnection;
@synthesize connectionTimer;

-(void)WebsewrviceAPICall:(NSString *)serviceURL  webserviceBodyInfo:(NSString *)soapMessage{
    
    NSLog(@"\nREQUEST URL:=================\n%@\nREQUEST FORMAT:=================\n%@\n", serviceURL, soapMessage);
    connectionTimer = [NSTimer scheduledTimerWithTimeInterval:SERVER_RESPONSE_TIMEOUT target:self selector:@selector(cancelInsingAPICall) userInfo:nil repeats:NO];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serviceURL]];
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    [theRequest setHTTPMethod:REQUEST_HTTP_METHODE_TYPE];
    [theRequest addValue:REQUEST_CONTENT_TYPE forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    
    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
   
    if( theConnection ){
        receivedData = [NSMutableData data];
    }
}

-(void)cancelInsingAPICall {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if ([receivedData length] == 0) {
        [theConnection cancel];
        NSError  *error = nil;
        [delegate downloadDidFailWithError:error];
    }
}

#pragma mark - Implementation callbacks
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (connectionTimer) {
        [connectionTimer invalidate];
        connectionTimer = nil;
    }
    
    [delegate downloadDidFailWithError:error];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    if (connectionTimer) {
        [connectionTimer invalidate];
        connectionTimer = nil;
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.responseString = [[NSString alloc] initWithBytes:[receivedData mutableBytes] length:[receivedData length] encoding:NSUTF8StringEncoding];
    //    NSLog(@"\nRESPONSE STRING:=================\n%@\n", self.responseString);
    [delegate downloadDidFinishLoading:self];
}


@end
