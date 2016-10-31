//
//  FontSizeTableViewController.m
//  Fonts
//
//  Created by 李业 on 16/10/27.
//  Copyright © 2016年 母壤. All rights reserved.
//

#import "FontSizeTableViewController.h"

@interface FontSizeTableViewController ()

@end

@implementation FontSizeTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSArray*)sizes{
    static NSArray* sizes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sizes = @[@9,
                                         @10,
                                         @11,
                                         @12,
                                         @13,
                                         @14,
                                         @18,
                                         @24,
                                         @36,
                                         @48,
                                         @64,
                                         @72,
                                         @96,
                                         @144];});
    return sizes;
}

- (UIFont*)fontForDisplayAtIndexPath:(NSIndexPath*)indexPath{
    NSNumber* pointSize = self.sizes[indexPath.row];
    return [self.font fontWithSize:pointSize.floatValue];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sizes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* iden = @"FontNameAndSize";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:iden forIndexPath:indexPath];
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.textLabel.text = self.font.fontName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ point", self.sizes[indexPath.row]];
    return cell;
}

@end
