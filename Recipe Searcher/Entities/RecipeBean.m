//
//  RecipeBean.m
//  Recipe Searcher
//
//  Created by Gema Virginia Toyos Lanza on 16/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import "RecipeBean.h"

@implementation RecipeBean


@synthesize name;
@synthesize ingredients;
@synthesize imageURL;
@synthesize recipeURL;


+ (RecipeBean*)instanceFromDictionary:(NSDictionary*)dictionary {
    
    RecipeBean *recipe = [[RecipeBean alloc]init];
    recipe.name = [NSNull null] == [dictionary valueForKey:@"title"]? nil : [dictionary valueForKey:@"title"];
    recipe.name = [recipe.name stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    recipe.name = [recipe.name stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    recipe.ingredients = [NSNull null] == [dictionary valueForKey:@"ingredients"]? nil : [dictionary valueForKey:@"ingredients"];
    recipe.imageURL = [NSNull null] == [dictionary valueForKey:@"thumbnail"]? nil : [dictionary valueForKey:@"thumbnail"];
    recipe.recipeURL = [NSNull null] == [dictionary valueForKey:@"href"]? nil : [dictionary valueForKey:@"href"];
    
    return recipe;
}

@end
