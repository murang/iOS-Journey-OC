//
//  FavoriteFonts.m
//  Fonts
//
//  Created by 母壤 on 16/10/11.
//  Copyright © 2016年 母壤. All rights reserved.
//

#import "FavoriteFonts.h"

@interface FavoriteFonts()

@property (strong, nonatomic) NSMutableArray* favorites;

@end

@implementation FavoriteFonts

+(instancetype)getInstance{
    static FavoriteFonts* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];
    if(self){
        NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
        NSArray* sortedList = [ud objectForKey:@"favorites"];
        if(sortedList){
            self.favorites = [sortedList mutableCopy];
        }else{
            self.favorites = [NSMutableArray array];
        }
    }
    return self;
}

-(void)saveFavorite{
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:self.favorites forKey:@"favorites"];
    [ud synchronize];
}

-(void)addFavorite:(id)item{
    [_favorites insertObject:item atIndex:0];
    [self saveFavorite];
}
-(void)removeFavorite:(id)item{
    [_favorites removeObject:item];
    [self saveFavorite];
}

@end
