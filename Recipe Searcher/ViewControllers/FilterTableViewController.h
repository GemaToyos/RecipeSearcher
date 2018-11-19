//
//  FilterTableViewController.h
//  Recipe Searcher
//
//  Created by Gema Virginia Toyos Lanza on 14/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//IBOutlets
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UITableView *table;

//IBActions
- (IBAction)addButton:(id)sender;

@end
