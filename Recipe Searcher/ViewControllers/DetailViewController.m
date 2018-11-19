//
//  DetailViewController.m
//  Recipe Searcher
//
//  Created by Gema Virginia Toyos Lanza on 14/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize recipe;
@synthesize img;
@synthesize name;
@synthesize ingredients;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Title view
    self.navigationItem.title = @"RECIPE DETAIL";
    
    //Title of the recipe
    name.text = recipe.name;
    
    //Set ingredients
    NSString *ingredientsText = @"";
    NSArray *ingredientsArray = [recipe.ingredients componentsSeparatedByString:@", "];
    for (NSString *ingredient in ingredientsArray){
        NSString *formattedString = [NSString stringWithFormat:@"%@\n",ingredient];
        ingredientsText = [ingredientsText stringByAppendingString:formattedString];
    }
    ingredients.text = ingredientsText;
    
    //Image of the recipe
    if ([recipe.imageURL isEqualToString:@""]){
        [img setImage:[UIImage imageNamed:@"recipebook"]];
    }else{
        NSURL *url = [NSURL URLWithString:recipe.imageURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *thumbnail = [UIImage imageWithData: data];
        [img setImage:thumbnail];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CUSTOM


/**
 
 Method to open the URL recipe
 
 @author Gema Virginia Toyos Lanza
 
 @param sender button id.
 
 @version 1.0
 
 */
- (IBAction)openRecipe:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:recipe.recipeURL];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
    }];
}
@end
