//
//  DatePickerViewController.m
//  iOS-Study-OC
//
//  Created by 李业 on 16/9/6.
//  Copyright © 2016年 Ash. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDate* now = [NSDate date];
    [_datePicker setDate:now animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPress:(id)sender {
    NSDate* date = _datePicker.date;
    NSString* msg = [[NSString alloc] initWithFormat:@"Select date is %@", date];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Date" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Fuck ye!" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
