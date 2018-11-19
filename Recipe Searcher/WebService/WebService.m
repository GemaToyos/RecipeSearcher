//
//  WebService.m
//  Recipe Searcher
//
//  Created by Gema Virginia Toyos Lanza on 14/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import "WebService.h"

@implementation WebService

@synthesize delegate;


#pragma mark SINGLETON METHODS


- (id)init {
    return self;
}

+ (id)sharedInstance {
    
    static WebService *sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[WebService alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    
    return sharedManager;
}


- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration{
    self = [[WebService alloc] init];
    // Session additional settings
    defaultSession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    return self;
}

-(NSURLSession*) getDefaultSession {
    return defaultSession;
}

#pragma mark - NSURLSessionDelegate METHODS


- (void)connectionDidFinishLoading:(NSData *)dataResult{
    
    NSError *errorJSON;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:dataResult
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&errorJSON];
    
    if ([delegate respondsToSelector:@selector(responseSearchReceived:)]) {
        [delegate responseSearchReceived:json];
    }
    
}

- (void)connectionServicedidFailWithError:(NSError *)error {
    
    if ([delegate respondsToSelector:@selector(responseSearchFailed:)]) {
        [delegate responseSearchFailed:error];
    }
    
}

- (void)setWebServiceDelegate:(id) webServiceDelegate {
    delegate = webServiceDelegate;
}

/**
 
 Method that makes the request to the API
 
 @author Gema Virginia Toyos Lanza
 
 @param queryDictionary Dictionary with the parameters of the ewquest.
 
 @version 1.0
 
 */
- (void)sendSearchRequest:(NSDictionary*)queryDictionary {
   
    
    NSString *url = @"http://www.recipepuppy.com/api/";
    
    NSURLComponents *components = [NSURLComponents componentsWithString:url];
   
    
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in queryDictionary) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:queryDictionary[key]]];
    }
    components.queryItems = queryItems;
    
    NSURL *urlCall = components.URL;
    
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:urlCall
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:120];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           
                                                           
                                                           if(error == nil){
                                                               [self connectionDidFinishLoading:data];
                                                           }else{
                                                               [self connectionServicedidFailWithError:error];
                                                           }
                                                           
                                                       }];
    [dataTask resume];
}





@end
