//
//  RecipeBean.h
//  Recipe Searcher
//
//  Created by Gema Virginia Toyos Lanza on 16/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeBean : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *ingredients;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *recipeURL;


+ (RecipeBean*)instanceFromDictionary:(NSDictionary*)dictionary;

@end
