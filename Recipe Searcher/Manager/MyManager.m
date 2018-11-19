//
//  MyManager.m
//  Recipe Searcher
//
//  Created by Gema Toyos on 17/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import "MyManager.h"

@implementation MyManager

@synthesize ingredientsList;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static MyManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        ingredientsList = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
