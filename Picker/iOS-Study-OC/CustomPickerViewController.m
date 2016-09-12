//
//  CustomPickerViewController.m
//  iOS-Study-OC
//
//  Created by 李业 on 16/9/6.
//  Copyright © 2016年 Ash. All rights reserved.
//

#import "CustomPickerViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CustomPickerViewController ()

@property (strong, nonatomic) NSArray* images;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (assign, nonatomic) SystemSoundID spinSound;
@property (assign, nonatomic) SystemSoundID winSound;

@end

@implementation CustomPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _images = @[[UIImage imageNamed:@"seven"],
                [UIImage imageNamed:@"bar"],
                [UIImage imageNamed:@"crown"],
                [UIImage imageNamed:@"apple"],
                [UIImage imageNamed:@"cherry"],
                [UIImage imageNamed:@"lemon"]
                ];
    _winLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)rock:(id)sender {
    BOOL win = NO;
    int numInRow = 1;
    int lastVal = -1;
    for(int i=0; i<5; i++){
        int newVal = arc4random_uniform((uint)[_images count]);
        if(newVal == lastVal){
            numInRow++;
        }
        else{
            numInRow = 1;
        }
        lastVal = newVal;
        [_picker selectRow:newVal inComponent:i animated:YES];
        [_picker reloadComponent:i];
        if(numInRow >= 3){
            win = YES;
        }
    }
    
    if(_spinSound == 0){
        NSURL *wsUrl = [[NSBundle mainBundle] URLForResource:@"crunch" withExtension:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)wsUrl, &_spinSound);
    }
    AudioServicesPlaySystemSound(_spinSound);
    
    
    if(win){
        [self performSelector:@selector(playWinSound) withObject:nil afterDelay:0.5];
    }
    else{
        [self performSelector:@selector(showBtn) withObject:nil afterDelay:0.5];
    }
    _btn.hidden = YES;
    _winLabel.text = @"";
}

-(void)showBtn{
    _btn.hidden = NO;
}

-(void)playWinSound{
    if(_winSound == 0){
        NSURL *wsUrl = [[NSBundle mainBundle] URLForResource:@"win" withExtension:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)wsUrl, &_winSound);
    }
    AudioServicesPlaySystemSound(_winSound);
    _winLabel.text = @"Fuck Yeah !";
    [self performSelector:@selector(showBtn) withObject:nil afterDelay:1.5];
}

#pragma mark -
#pragma mark Picker Data Source Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 5;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_images count];
}

#pragma mark Picker Delegate Method
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIImage *img = _images[row];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    return imgView;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 64;
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
