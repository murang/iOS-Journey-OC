//
//  SearchTableViewController.h
//  TableSections
//
//  Created by 李业 on 16/9/22.
//  Copyright © 2016年 Ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UITableViewController
<UISearchResultsUpdating>

-(instancetype)initWithNames:(NSDictionary*)names Keys:(NSArray*)keys;

@end
