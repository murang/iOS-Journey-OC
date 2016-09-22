//
//  SearchTableViewController.m
//  TableSections
//
//  Created by 李业 on 16/9/22.
//  Copyright © 2016年 Ash. All rights reserved.
//

#import "SearchTableViewController.h"

static NSString* iden = @"newidforsearch";

@interface SearchTableViewController ()

@property (strong, nonatomic) NSDictionary* names;
@property (strong, nonatomic) NSArray* keys;
@property (strong, nonatomic) NSMutableArray* filterNames;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:iden];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithNames:(NSDictionary *)names Keys:(NSArray *)keys{
    if(self = [super initWithStyle:UITableViewStylePlain]){
        self.names = names;
        self.keys = keys;
        self.filterNames = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_filterNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden forIndexPath:indexPath];
    cell.textLabel.text = _filterNames[indexPath.row];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - search controller

static const NSUInteger longNameSize = 6;
static const NSInteger shortNameButtonIndex = 1;
static const NSInteger longNameButtonIndex = 2;

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString* searchKey = searchController.searchBar.text;
    NSInteger buttonIndex = searchController.searchBar.selectedScopeButtonIndex;
    [self.filterNames removeAllObjects];
    if(searchKey.length > 0){
        NSPredicate* predicate = [NSPredicate predicateWithBlock:^BOOL(NSString* name, NSDictionary<NSString *,id> * _Nullable bindings) {
            NSUInteger len = name.length;
            if((buttonIndex == shortNameButtonIndex && len >= longNameSize) || (buttonIndex == longNameButtonIndex && len < longNameSize)){
                return NO;
            }
            NSRange range = [name rangeOfString:searchKey options:NSCaseInsensitiveSearch];
            return range.location != NSNotFound;
        }];
        for(NSString* key in self.keys){
            NSArray* sectionNames = self.names[key];
            NSArray* matchNames = [sectionNames filteredArrayUsingPredicate:predicate];
            [self.filterNames addObjectsFromArray:matchNames];
        }
    }
    [self.tableView reloadData];
}

@end
