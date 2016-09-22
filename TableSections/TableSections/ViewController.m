//
//  ViewController.m
//  TableSections
//
//  Created by 李业 on 16/9/22.
//  Copyright © 2016年 Ash. All rights reserved.
//

#import "ViewController.h"
#import "SearchTableViewController.h"

static NSString* iden = @"sectionIdentify";

@interface ViewController ()

@property (copy, nonatomic) NSDictionary* names;
@property (copy, nonatomic) NSArray* keys;
@property (weak, nonatomic) IBOutlet UITableView *sectionTable;
@property (strong, nonatomic) UISearchController* sc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_sectionTable registerClass:[UITableViewCell class] forCellReuseIdentifier:iden];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@".plist"];
    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
    self.keys = [[_names allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    SearchTableViewController* searchTV = [[SearchTableViewController alloc] initWithNames:self.names Keys:self.keys];
    self.sc = [[UISearchController alloc] initWithSearchResultsController:searchTV];
    UISearchBar* searchBar = _sc.searchBar;
    searchBar.scopeButtonTitles = @[@"All", @"Short", @"Long"];
    searchBar.placeholder = @"Enter a fucking name !";
    [searchBar sizeToFit];
    _sectionTable.tableHeaderView = searchBar;
    _sc.searchResultsUpdater = searchTV;
    
    _sectionTable.sectionIndexBackgroundColor = [UIColor blackColor];
    _sectionTable.sectionIndexTrackingBackgroundColor = [UIColor darkGrayColor];
    _sectionTable.sectionIndexColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_keys count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString* key = _keys[section];
    NSArray* sectionNames = _names[key];
    return [sectionNames count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _keys[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:iden forIndexPath:indexPath];
    NSString* key = _keys[indexPath.section];
    NSArray* nameScetion = _names[key];
    cell.textLabel.text = nameScetion[indexPath.row];
    return cell;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.keys;
}

@end
