//
//  FontListTableViewController.m
//  Fonts
//
//  Created by 李业 on 16/10/27.
//  Copyright © 2016年 母壤. All rights reserved.
//

#import "FontListTableViewController.h"
#import "FavoriteFonts.h"
#import "FontSizeTableViewController.h"
#import "FontInfoViewController.h"

@interface FontListTableViewController ()

@property (assign, nonatomic) CGFloat cellPointSize;

@end

@implementation FontListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    UIFont* preferredTableViewFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.cellPointSize = preferredTableViewFont.pointSize;
    
    if(self.showFavorites){
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(UIFont*)fontForDisplayAtIndexPath:(NSIndexPath*)indexPath{
    NSString* fontName = self.fontNames[indexPath.row];
    return [UIFont fontWithName:fontName size:self.cellPointSize];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.showFavorites){
        self.fontNames = [FavoriteFonts getInstance].favorites;
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fontNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* Celliden = @"FontName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Celliden                                                                               forIndexPath:indexPath];
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.textLabel.text = self.fontNames[indexPath.row];
    cell.detailTextLabel.text = self.fontNames[indexPath.row];
    // Configure the cell...
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return self.showFavorites;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.showFavorites == NO)return;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSString* fav = self.fontNames[indexPath.row];
        [[FavoriteFonts getInstance] removeFavorite:fav];
        self.fontNames = [FavoriteFonts getInstance].favorites;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[FavoriteFonts getInstance] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
    self.fontNames = [FavoriteFonts getInstance].favorites;
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
    UIFont* font = [self fontForDisplayAtIndexPath:indexPath];
    [segue.destinationViewController navigationItem].title = font.fontName;
    if([segue.identifier isEqualToString:@"ShowFontSize"]){
        FontSizeTableViewController* sizeView = segue.destinationViewController;
        sizeView.font = font;
    }else if([segue.identifier isEqualToString:@"ShowFontInfo"]){
        FontInfoViewController* infoView = segue.destinationViewController;
        infoView.font = font;
        infoView.favorite = [[FavoriteFonts getInstance].favorites containsObject:font.fontName];
    }
}


@end
