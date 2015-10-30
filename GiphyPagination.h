//
//  GiphyPagination.h
//  EmojiKeyboard
//
//  Created by TangYafeng on 15/10/27.
//  Copyright © 2015年 pinssible. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiphyPagination : NSObject

@property (readwrite, nonatomic) int total_count;
@property (readwrite, nonatomic) int count;
@property (readwrite, nonatomic) int offset;

- (instancetype) initWithDictionary:(NSDictionary*) dictionary;

@end
