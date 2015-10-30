//
//  GiphyPagination.m
//  EmojiKeyboard
//
//  Created by TangYafeng on 15/10/27.
//  Copyright © 2015年 pinssible. All rights reserved.
//

#import "GiphyPagination.h"

@implementation GiphyPagination

- (instancetype) initWithDictionary:(NSDictionary*) dictionary {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.total_count = [dictionary[@"total_count"] intValue];
    self.count = [dictionary[@"count"] intValue];
    self.offset = [dictionary[@"offset"] intValue];
    
    return self;
}

@end
