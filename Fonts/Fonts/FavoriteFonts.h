//
//  FavoriteFonts.h
//  Fonts
//
//  Created by 母壤 on 16/10/11.
//  Copyright © 2016年 母壤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteFonts : NSObject

+(instancetype)getInstance;

-(NSArray*)favorites;

-(void)addFavorite:(id)item;
-(void)removeFavorite:(id)item;

@end
