//
//  RecipeTableViewController.h
//  Recipe Searcher
//
//  Created by Gema Virginia Toyos Lanza on 14/11/18.
//  Copyright © 2018 Gema Toyos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"


@interface RecipeTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,WebServiceDelegate,UISearchResultsUpdating>{

    NSMutableArray *contentList;
    
    BOOL isSearching;

}

@property (strong, nonatomic) IBOutlet UITableView *table;





@end

