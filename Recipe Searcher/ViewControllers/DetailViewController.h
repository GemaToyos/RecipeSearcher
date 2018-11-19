//
//  DetailViewController.h
//  Recipe Searcher
//
//  Created by Gema Virginia Toyos Lanza on 14/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeBean.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UITextView *ingredients;

- (IBAction)openRecipe:(id)sender;

@property (nonatomic, retain) RecipeBean *recipe;

@end
