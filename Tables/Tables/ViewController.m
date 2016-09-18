//
//  ViewController.m
//  Tables
//
//  Created by 李业 on 16/9/12.
//  Copyright © 2016年 Ash. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *list;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _list = @[@"zhao",@"qian",@"shun",@"li",@"zhou",@"wu",@"zhen",@"wang",@"zhao",@"qian",@"shun",@"li",@"zhou",@"wu",@"zhen",@"wang",@"zhao",@"qian",@"shun",@"li",@"zhou",@"wu",@"zhen",@"wang"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"SinpleTableIdenty";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = _list[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:36];
    cell.detailTextLabel.text = @"fuck yeah";
    UIImage *img = [UIImage imageNamed:@"star"];
    cell.imageView.image = img;
    UIImage *himg = [UIImage imageNamed:@"star2"];
    cell.imageView.highlightedImage = himg;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row % 8;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row%2 == 0){
        return nil;
    }else{
        return indexPath;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:_list[indexPath.row] message:@"fuck!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"yyy" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
