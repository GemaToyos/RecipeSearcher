//
//  WebService.h
//  Recipe Searcher
//
//  Created by Gema Virginia Toyos Lanza on 14/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServiceDelegate;

@interface WebService : NSObject <NSURLSessionDelegate>{
    
    NSURLSessionConfiguration *defaultConfigObject;
    NSURLSession *defaultSession;
    
}

@property(nonatomic, assign) id <WebServiceDelegate> delegate;

+ (id)sharedInstance;

- (void)setWebServiceDelegate:(id) webServiceDelegate;

- (void)sendSearchRequest:(NSDictionary*)queryDictionary;

- (NSURLSession *)getDefaultSession;

@end


@protocol WebServiceDelegate <NSObject>

@optional

- (void)responseSearchReceived:(NSDictionary *)json;
- (void)responseSearchFailed:(NSError *)error;

@end
