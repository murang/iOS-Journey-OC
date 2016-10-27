//
//  FontListTableViewController.h
//  Fonts
//
//  Created by 李业 on 16/10/27.
//  Copyright © 2016年 母壤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontListTableViewController : UITableViewController

@property (copy, nonatomic) NSArray* fontNames;
@property (assign, nonatomic) BOOL showFavorites;

@end
