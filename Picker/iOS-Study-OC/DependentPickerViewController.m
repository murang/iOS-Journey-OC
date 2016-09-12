//
//  DependentPickerViewController.m
//  iOS-Study-OC
//
//  Created by 李业 on 16/9/6.
//  Copyright © 2016年 Ash. All rights reserved.
//

#import "DependentPickerViewController.h"

@interface DependentPickerViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *dependentPicker;
@property (strong, nonatomic) NSDictionary *dic;
@property (strong, nonatomic) NSArray *names1;
@property (strong, nonatomic) NSArray *names2;
@end

@implementation DependentPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *url = [bundle URLForResource:@"statedictionary" withExtension:@"plist"];
    _dic = [NSDictionary dictionaryWithContentsOfURL:url];
    NSArray *allKeys = [_dic allKeys];
    _names1 = [allKeys sortedArrayUsingSelector:@selector(compare:)];
    _names2 = _dic[_names1[0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPress:(id)sender {
    NSString *str1 = _names1[[_dependentPicker selectedRowInComponent:0]];
    NSString *str2 = _names2[[_dependentPicker selectedRowInComponent:1]];
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
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        NSString *key = _names1[row];
        _names2 = _dic[key];
        [_dependentPicker reloadComponent:1];
        [_dependentPicker selectRow:0 inComponent:1 animated:YES];
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    CGFloat pickerWidth = pickerView.bounds.size.width;
    if(component == 0){
        return pickerWidth/3*2;
    }
    else{
        return pickerWidth/3;
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
