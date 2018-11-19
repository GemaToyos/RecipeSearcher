//
//  MyManager.h
//  Recipe Searcher
//
//  Created by Gema Toyos on 17/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyManager : NSObject

@property (nonatomic, retain) NSMutableArray *ingredientsList;

+ (id)sharedManager;

@end

NS_ASSUME_NONNULL_END
