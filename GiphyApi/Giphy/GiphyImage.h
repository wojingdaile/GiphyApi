//
//  GiphyImage.h
//  EmojiKeyboard
//
//  Created by TangYafeng on 15/10/27.
//  Copyright © 2015年 pinssible. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@interface GiphyImage : NSObject

@property (readonly, strong, nonatomic) NSURL * url;
@property (readonly, nonatomic) CGFloat width;
@property (readonly, nonatomic) CGFloat height;
@property (readonly, nonatomic) int size;
@property (readonly, nonatomic) int frames;
@property (readonly, strong, nonatomic) NSURL * mp4;
@property (readonly, nonatomic) int mp4Size;
@property (readonly, strong, nonatomic) NSURL * webp;
@property (readonly, nonatomic) int webpSize;

- (instancetype) initWithDictionary:(NSDictionary*) dictionary;
- (NSURLSessionDataTask *) getRawImageWithBlock:(void (^)(NSData *, NSError *error)) block;

@end
