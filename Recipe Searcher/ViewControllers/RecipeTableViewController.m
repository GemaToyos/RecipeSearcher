//
//  RecipeTableViewController.m
//  Recipe Searcher
//
//  Created by Gema Virginia Toyos Lanza on 14/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import "RecipeTableViewController.h"
#import "RecipeBean.h"
#import "DetailViewController.h"
#import "MyManager.h"

@interface RecipeTableViewController ()

@end

@implementation RecipeTableViewController

UISearchController *searchController;

@synthesize table;
RecipeBean *detailRecipe;
MyManager *managerMain;

#pragma mark - UIVIEWCONTROLLER

- (void)viewDidLoad {
    [super viewDidLoad];
    
    managerMain = [MyManager sharedManager];
    
    //Inicializamos la lista de resultados
    contentList = [[NSMutableArray alloc] init];
   
    //Inicializamos el buscador y agregar el delegado
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [searchController.searchBar sizeToFit];
    table.tableHeaderView = searchController.searchBar;
    self.definesPresentationContext = YES;
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NAVIGATION

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier]
         isEqualToString:@"OpenDetail"]){
        DetailViewController *viewController = [segue destinationViewController];
        viewController.recipe = detailRecipe;
    }
    
}


#pragma mark - UITABLEVIEW DELEGATE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"RecipeTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    RecipeBean *recipe = [contentList objectAtIndex:indexPath.row];
    NSString *title = recipe.name;
    cell.textLabel.text = title;
    cell.imageView.image = [UIImage imageNamed:@"recipebook"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITABLEVIEW DATA SOURCE

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    detailRecipe = [contentList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"OpenDetail" sender:self];
}

#pragma mark - WEBSERVICE DELEGATE


/**
 
 Response of the service.
 
 @author Gema Virginia Toyos Lanza
 
 @param json JSON with the list of recipes.
 
 @version 1.0
 
 */
- (void)responseSearchReceived:(NSDictionary *)json{
    contentList = [[NSMutableArray alloc] init];
    for (NSDictionary* resultsDictionary in [[json valueForKey:@"results"]objectEnumerator]){
        RecipeBean *recipe = [RecipeBean instanceFromDictionary:resultsDictionary];
        [contentList addObject:recipe];
    }
    [table reloadData];
}


/**
 
 Response of the service with errors.
 
 @author Gema Virginia Toyos Lanza
 
 @param error Error in the service.
 
 @version 1.0
 
 */
- (void)responseSearchFailed:(NSError *)error{
    NSLog(@"La llamada ha fallado. Error: %@",error);
}

#pragma mark - UISEARCH CONTROLLER DELEGATE


- (void)updateSearchResultsForSearchController:(UISearchController *)sController{
    if (![sController.searchBar.text isEqualToString:@""]){
        [self requestServices:sController.searchBar.text];
    }
    
}

#pragma mark - CUSTOM METHODS

/**
 
 Method to call to the web service.
 
 @author Gema Virginia Toyos Lanza
 
 @param searchText text obtained in the search bar.
 
 @version 1.0
 
 */
- (void)requestServices:(NSString *) searchText {
    
    NSString *ingredients = @"";
    for (NSString *i in managerMain.ingredientsList){
        NSString *formattedText = [NSString stringWithFormat:@"%@,",i];
        ingredients = [ingredients stringByAppendingString:formattedText];
    }
    if (![ingredients isEqualToString:@""]){
        ingredients = [ingredients substringToIndex:[ingredients length]-1];
    }
    NSDictionary *queryDictionary = @{ @"q": searchText, @"i": ingredients};
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[WebService sharedInstance]setWebServiceDelegate:self];
        [[WebService sharedInstance]sendSearchRequest:queryDictionary];
    });
}


@end
