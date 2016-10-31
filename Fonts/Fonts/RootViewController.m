//
//  RootViewController.m
//  Fonts
//
//  Created by 母壤 on 16/10/11.
//  Copyright © 2016年 母壤. All rights reserved.
//

#import "RootViewController.h"
#import "FavoriteFonts.h"
#import "FontListTableViewController.h"

@interface RootViewController ()

@property (copy, nonatomic)NSArray* familyNames;
@property (assign, nonatomic)CGFloat cellSize;
@property (strong, nonatomic)FavoriteFonts* favoriteFonts;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)];
    UIFont* preferredFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.cellSize = preferredFont.pointSize;
    self.favoriteFonts = [FavoriteFonts getInstance];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(UIFont*)fontForDisplayAtIndexPath:(NSIndexPath*)indexPath{
    if(indexPath.section == 0){
        NSString* familyName = self.familyNames[indexPath.row];
        NSString* fontName = [[UIFont fontNamesForFamilyName:familyName] firstObject];
        return [UIFont fontWithName:fontName size:self.cellSize];
    }else{
        return nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self.favoriteFonts.favorites count] > 0){
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return [self.familyNames count];
    }
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"All Font Families";
    }
    return @"Favorite Fonts";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* FamilyNameCell = @"FamilyName";
    static NSString* FavoriteCell = @"Favorites";
    UITableViewCell *cell = nil;
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:FamilyNameCell forIndexPath:indexPath];
        cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
        cell.textLabel.text = self.familyNames[indexPath.row];
        cell.detailTextLabel.text = self.familyNames[indexPath.row];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:FavoriteCell forIndexPath:indexPath];
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
    FontListTableViewController* flView = segue.destinationViewController;
    if(indexPath.section == 0){
        NSString* familyName = self.familyNames[indexPath.row];
        flView.fontNames = [[UIFont fontNamesForFamilyName:familyName] sortedArrayUsingSelector:@selector(compare:)];
        flView.navigationItem.title = familyName;
        flView.showFavorites = NO;
    }else{
        flView.fontNames = self.favoriteFonts.favorites;
        flView.navigationItem.title = @"Favorites";
        flView.showFavorites = YES;
    }
}


@end
