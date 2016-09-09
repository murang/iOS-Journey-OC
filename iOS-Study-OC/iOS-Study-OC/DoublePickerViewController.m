//
//  DoublePickerViewController.m
//  iOS-Study-OC
//
//  Created by 李业 on 16/9/6.
//  Copyright © 2016年 Ash. All rights reserved.
//

#import "DoublePickerViewController.h"

@interface DoublePickerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *doublePicker;
@property (strong, nonatomic) NSArray *names1;
@property (strong, nonatomic) NSArray *names2;

@end

@implementation DoublePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _names1 = @[@"fuck", @"shit", @"bitch", @"asshole"];
    _names2 = @[@"wemon", @"man", @"renyao"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPress:(id)sender {
    NSString* str1 = _names1[[_doublePicker selectedRowInComponent:0]];
    NSString* str2 = _names2[[_doublePicker selectedRowInComponent:1]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:str1 message:str2 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark -
#pragma mark Picker Data Source Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return [_names1 count];
    }
    else{
        return [_names2 count];
    }
}

#pragma mark Picker Delegate Method
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return _names1[row];
    }
    else{
        return _names2[row];
    }
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
