//
//  CustomTableViewCell.m
//  Tables
//
//  Created by 李业 on 16/9/18.
//  Copyright © 2016年 Ash. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel* nameLabel;
@property (strong, nonatomic) IBOutlet UILabel* colorLabel;

@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
        UILabel* nameMark = [[UILabel alloc] initWithFrame:nameLabelRect];
        nameMark.textAlignment = NSTextAlignmentRight;
        nameMark.text = @"Name";
        nameMark.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:nameMark];
        CGRect colorLabelRect = CGRectMake(0, 26, 70, 15);
        UILabel* colorMark = [[UILabel alloc] initWithFrame:colorLabelRect];
        colorMark.textAlignment = NSTextAlignmentRight;
        colorMark.text = @"Color";
        colorMark.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:colorMark];
        
        CGRect nameRect = CGRectMake(80, 5, 200, 15);
        _nameLabel = [[UILabel alloc] initWithFrame:nameRect];
        [self.contentView addSubview:_nameLabel];
        CGRect colorRect = CGRectMake(80, 26, 200, 15);
        _colorLabel = [[UILabel alloc] initWithFrame:colorRect];
        [self.contentView addSubview:_colorLabel];
    }
    return self;
}
 */

-(void)setName:(NSString*)n{
    if(![n isEqualToString:_name]){
        _name = [n copy];
        _nameLabel.text = _name;
    }
}

-(void)setColor:(NSString*)c{
    if(![c isEqualToString:_color]){
        _color = [c copy];
        _colorLabel.text = _color;
    }
}

@end
