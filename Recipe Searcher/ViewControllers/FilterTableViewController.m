//
//  FilterTableViewController.m
//  Recipe Searcher
//
//  Created by Gema Virginia Toyos Lanza on 14/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import "FilterTableViewController.h"
#import "MyManager.h"

@interface FilterTableViewController ()

@end

@implementation FilterTableViewController

@synthesize table;
@synthesize textfield;

MyManager *manager;

#pragma mark - UIVIEWCONTROLLER

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Title view
    self.navigationItem.title = @"ADD INGREDIENTS";
    
    manager = [MyManager sharedManager];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITABLEVIEW DELEGATE


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [manager.ingredientsList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"IngredientCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *ingredientText = [manager.ingredientsList objectAtIndex:indexPath.row];
    cell.textLabel.text = ingredientText;
    cell.imageView.image = [UIImage imageNamed:@"tomato"];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - UITABLEVIEW DATA SOURCE

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [manager.ingredientsList removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

#pragma mark - IBACTIONS

/**
 
 Method to add ingredients to the filter list
 
 @author Gema Virginia Toyos Lanza
 
 @param sender button id.
 
 @version 1.0
 
 */
- (IBAction)addButton:(id)sender {
    if ([textfield.text length] > 0){
        [manager.ingredientsList addObject:textfield.text];
        textfield.text = @"";
        [table reloadData];
        [textfield resignFirstResponder];
    }
}
@end
