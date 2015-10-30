//
//  GiphyImage.m
//  EmojiKeyboard
//
//  Created by TangYafeng on 15/10/27.
//  Copyright © 2015年 pinssible. All rights reserved.
//

#import "GiphyImage.h"
#import "AFNetworking.h"

@interface GiphyImage()

@property (readwrite, strong, nonatomic) NSURL * url;
@property (readwrite, nonatomic) CGFloat width;
@property (readwrite, nonatomic) CGFloat height;
@property (readwrite, nonatomic) int size;
@property (readwrite, nonatomic) int frames;
@property (readwrite, strong, nonatomic) NSURL * mp4;
@property (readwrite, nonatomic) int mp4Size;
@property (readwrite, strong, nonatomic) NSURL * webp;
@property (readwrite, nonatomic) int webpSize;

@end

@implementation GiphyImage

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.url = [NSURL URLWithString:dictionary[@"url"]];
    self.width = [dictionary[@"width"] floatValue];
    self.height = [dictionary[@"height"] floatValue];
    self.size = [dictionary[@"size"] intValue];
    self.frames = [dictionary[@"frames"] intValue];
    self.mp4 = [NSURL URLWithString:dictionary[@"mp4"]];
    self.mp4Size = [dictionary[@"mp4_size"] intValue];
    self.webp = [NSURL URLWithString:dictionary[@"webp"]];
    self.webpSize = [dictionary[@"webp_size"] intValue];
    
    return self;
}

@end
