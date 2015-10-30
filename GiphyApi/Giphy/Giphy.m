//
//  Giphy.m
//  Giphy
//
//  Created by alexchoi on 8/18/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//
//https://github.com/giphy/GiphyAPI
#import "Giphy.h"
#import "AFNetworking.h"
#import "STHTTPRequest.h"

@interface Giphy ()
@property (readwrite, strong, nonatomic) NSString * gifID;
@property (readwrite, strong, nonatomic) NSString * type;
@property (readwrite, strong, nonatomic) NSURL * url;
@property (readwrite, strong, nonatomic) NSURL * bitlyURL;
@property (readwrite, strong, nonatomic) NSURL * bitlyGIFURL;
@property (readwrite, strong, nonatomic) NSURL * embedURL;
@property (readwrite, strong, nonatomic) NSURL * contentURL;
@property (readwrite, strong, nonatomic) NSString * username;
@property (readwrite, strong, nonatomic) NSURL * source;
@property (readwrite, strong, nonatomic) NSString * rating;
@property (readwrite, strong, nonatomic) NSString * caption;
@property (readwrite, strong, nonatomic) NSDate * importDatetime;
@property (readwrite, strong, nonatomic) NSDate * trendingDateTime;
@property (readwrite, strong, nonatomic) GiphyImage *fixedHeightImage;
@property (readwrite, strong, nonatomic) GiphyImage *fixedHeightStillImage;
@property (readwrite, strong, nonatomic) GiphyImage *fixedHeightDownSampledImage;
@property (readwrite, strong, nonatomic) GiphyImage *fixedWidthImage;
@property (readwrite, strong, nonatomic) GiphyImage *fixedWidthStillImage;
@property (readwrite, strong, nonatomic) GiphyImage *fixedWidthDownsampledImage;
@property (readwrite, strong, nonatomic) GiphyImage *fixedHeightSmallImage;
@property (readwrite, strong, nonatomic) GiphyImage *fixedHeightSmallStillImage;
@property (readwrite, strong, nonatomic) GiphyImage *fixedWidthSmallImage;
@property (readwrite, strong, nonatomic) GiphyImage *fixedWidthSmallStillImage;
@property (readwrite, strong, nonatomic) GiphyImage *downsizedImage;
@property (readwrite, strong, nonatomic) GiphyImage *downsizedStillImage;
@property (readwrite, strong, nonatomic) GiphyImage *downsizedLarge;
@property (readwrite, strong, nonatomic) GiphyImage *orignal;
@property (readwrite, strong, nonatomic) GiphyImage *orignalStill;
@end

@implementation Giphy
static NSString * kGiphyAPIKey = @"dc6zaTOxFJmzC";
static int kMetaExpire = 24 * 60 * 60 * 1000;

- (instancetype) initWithDictionary: (NSDictionary *) dictionary
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.gifID = dictionary[@"id"];
    self.type = dictionary[@"type"];
    self.url = [NSURL URLWithString:dictionary[@"url"]];
    self.bitlyURL = [NSURL URLWithString:dictionary[@"bitly_url"]];
    self.bitlyGIFURL = [NSURL URLWithString:dictionary[@"bitly_gif_url"]];
    self.embedURL = [NSURL URLWithString:dictionary[@"embed_url"]];
    self.contentURL = [NSURL URLWithString:dictionary[@"content_url"]];
    self.username = dictionary[@"username"];
    self.source = [NSURL URLWithString:dictionary[@"source"]];
    self.rating = dictionary[@"rating"];
    self.caption = dictionary[@"caption"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.trendingDateTime = [dateFormatter dateFromString:dictionary[@"trending_datetime"]];
    self.importDatetime = [dateFormatter dateFromString:dictionary[@"import_datetime"]];
    
    NSDictionary *images = dictionary[@"images"];
    self.fixedHeightImage = [[GiphyImage alloc] initWithDictionary:images[@"fixed_height"]];
    self.fixedHeightStillImage = [[GiphyImage alloc] initWithDictionary:images[@"fixed_height_still"]];
    self.fixedHeightDownSampledImage = [[GiphyImage alloc] initWithDictionary:images[@"fixed_height_downsampled"]];
    self.fixedWidthImage = [[GiphyImage alloc] initWithDictionary:images[@"fixed_width"]];
    self.fixedWidthStillImage = [[GiphyImage alloc] initWithDictionary:images[@"fixed_width_still"]];
    self.fixedWidthDownsampledImage = [[GiphyImage alloc] initWithDictionary:images[@"fixed_width_downsampled"]];
    self.fixedHeightSmallImage = [[GiphyImage alloc] initWithDictionary:images[@"fixed_height_small"]];
    self.fixedHeightSmallStillImage = [[GiphyImage alloc] initWithDictionary:images[@"fixed_height_small_still"]];
    self.fixedWidthSmallImage = [[GiphyImage alloc] initWithDictionary:images[@"fixed_width_small"]];
    self.fixedWidthSmallStillImage = [[GiphyImage alloc] initWithDictionary:images[@"fixed_width_small_still"]];
    self.downsizedImage = [[GiphyImage alloc] initWithDictionary:images[@"downsized"]];
    self.downsizedStillImage = [[GiphyImage alloc] initWithDictionary:images[@"downsized_still"]];
    self.downsizedLarge = [[GiphyImage alloc] initWithDictionary:images[@"downsized_large"]];
    self.orignal = [[GiphyImage alloc] initWithDictionary:images[@"original"]];
    self.orignalStill = [[GiphyImage alloc] initWithDictionary:images[@"original_still"]];
    
    return self;
}

+ (void) setGiphyAPIKey:(NSString *) APIKey
{
    kGiphyAPIKey = APIKey;
}

+ (NSString *) giphyAPIKey
{
    return kGiphyAPIKey;
}

+ (NSArray *) GiphyArrayFromDictArray:(NSArray *) array
{
    NSMutableArray * gifArray = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * dict = obj;
        Giphy * gif = [[Giphy alloc] initWithDictionary:dict];
        [gifArray addObject:gif];
    }];
    return gifArray;
}

+ (NSURLRequest *) giphySearchRequestForTerm:(NSString *) term limit:(NSUInteger) limit offset:(NSInteger) offset
{
    return [self requestForEndPoint:@"/search" params:@{@"limit": @(limit), @"offset": @(offset), @"q": term}];
}

+ (NSURLRequest *) giphyTrendingRequestWithLimit:(NSUInteger) limit offset:(NSUInteger) offset
{
    return [self requestForEndPoint:@"/trending" params:@{@"limit": @(limit), @"offset": @(offset)}];
}

+ (NSURLRequest *) giphyRequestForGIFWithID:(NSString *) ID
{
    return [self requestForEndPoint:[NSString stringWithFormat:@"/%@",ID] params:nil];
}
+ (NSURLRequest *) giphyRequestForGIFsWithIDs:(NSArray *) IDs
{
    return [self requestForEndPoint:@"" params:@{@"ids": [IDs componentsJoinedByString:@","]}];
}

+ (NSURLRequest *) giphyTranslationRequestForTerm:(NSString *) term
{
    return [self requestForEndPoint:@"/translate" params:@{@"limit": @(1), @"s": term}];
}
/** Response on this endpoint is inconsistent with the rest of the endpoints' responses*/
+ (NSURLRequest *) giphyRequestForRandomGIFWithTag:(NSString *) tag
{
    return [self requestForEndPoint:@"/random" params:@{@"tag": tag}];
}

+ (NSURLRequest *) requestForEndPoint:(NSString *) endpoint params:(NSDictionary *) params
{
    NSString * base = @"https://api.giphy.com/v1/gifs";
    NSString * withEndPoint = [NSString stringWithFormat:@"%@%@", base, endpoint];
    NSError * error;
    
    NSMutableDictionary * paramsWithAPIKey = [NSMutableDictionary dictionaryWithDictionary:params];
    [paramsWithAPIKey setObject:kGiphyAPIKey forKey:@"api_key"];
    NSURLRequest * request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:withEndPoint parameters:paramsWithAPIKey error:&error];
    return request;
}

+ (NSURLSessionDataTask *) searchGiphyWithTerm:(NSString *) searchTerm limit:(NSUInteger) limit offset:(NSUInteger) offset completion:(void (^) (NSArray * results, GiphyPagination * pagination, NSError * error)) block
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self giphySearchRequestForTerm:searchTerm limit:limit offset:offset];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            block(nil, nil, error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            error = error ?: [self customErrorFromResults:results];
            if (error) {
                block(nil, nil, error);
            } else {
                NSArray * gifArray = [Giphy GiphyArrayFromDictArray:results[@"data"]];
                GiphyPagination *pagination = [[GiphyPagination alloc] initWithDictionary:results[@"pagination"]];
                block(gifArray, pagination, nil);
            }
        }
    }];
    [task resume];
    return task;
}

+ (NSURLSessionDataTask *) trendingGIFsWithlimit:(NSUInteger) limit offset:(NSInteger) offset completion:(void (^) (NSArray * results, GiphyPagination * pagination, NSError * error)) block
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self giphyTrendingRequestWithLimit:limit offset:offset];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            block(nil, nil, error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            error = error ?: [self customErrorFromResults:results];
            if (error) {
                block(nil, nil, error);
            } else {
                NSArray * gifArray = [Giphy GiphyArrayFromDictArray:results[@"data"]];
                GiphyPagination *pagination = [[GiphyPagination alloc] initWithDictionary:results[@"pagination"]];
                block(gifArray, pagination, nil);
            }
        }
    }];
    [task resume];
    return task;
}

+ (NSURLSessionDataTask *) giphyTranslationForTerm:(NSString *)term completion:(void (^)(Giphy *, NSError *))block
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self giphyTranslationRequestForTerm:term];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            block(nil, error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            error = error ?: [self customErrorFromResults:results];
            if (error) {
                block(nil, error);
            } else {
                Giphy * result = [[Giphy alloc] initWithDictionary:results[@"data"]];
                block(result, nil);
            }
        }
    }];
    [task resume];
    return task;
}


+ (NSURLSessionDataTask *) gifForID:(NSString *)ID completion:(void (^)(Giphy *, NSError *))block
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self giphyRequestForGIFWithID:ID];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            block(nil, error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            error = error ?: [self customErrorFromResults:results];
            if (error) {
                block(nil, error);
            } else {
                Giphy * result = [[Giphy alloc] initWithDictionary:results[@"data"]];
                block(result, nil);
            }
        }
    }];
    [task resume];
    return task;
}

+ (NSURLSessionDataTask *) gifsForIDs:(NSArray *)IDs completion:(void (^)(NSArray *, GiphyPagination * pagination, NSError *))block
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self giphyRequestForGIFsWithIDs:IDs];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            block(nil, nil, error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            error = error ?: [self customErrorFromResults:results];
            if (error) {
                block(nil, nil, error);
            } else {
                NSArray * gifs = [Giphy GiphyArrayFromDictArray:results[@"data"]];
                GiphyPagination *pagination = [[GiphyPagination alloc] initWithDictionary:results[@"pagination"]];
                block(gifs, pagination, nil);
            }
        }
    }];
    [task resume];
    return task;
}

// synchronized api
+ (NSArray *)searchGiphyWithTerm:(NSString *)searchTerm limit:(NSUInteger)limit
{
    NSURLRequest * request = [self giphySearchRequestForTerm:searchTerm limit:limit offset:0];
    
    NSError *error;
    STHTTPRequest *synchronizeRequest = [STHTTPRequest requestWithURLString:[[request URL] absoluteString]];
    NSString *data = [synchronizeRequest startSynchronousWithError:&error];
    
    NSDictionary *results;
    if (!error) {
        results = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        
        if (error) {
            NSLog(@"synchronized searchGiphyWithTerm json parse failed");
            return nil;
        }
        
        return results[@"data"];
        
    } else {
        NSLog(@"synchronized searchGiphyWithTerm http request failed.error: %@", error);
    }
    
    
    return nil;
}

+ (NSError *)customErrorFromResults:(NSDictionary *)results
{
    NSArray * resultsData = results[@"data"];
    if ([resultsData count] == 0) {
        return [[NSError alloc] initWithDomain:@"com.giphy.ios" code:-1 userInfo:@{@"error_message" : @"No results were found"}];
    }
    return nil;
}

@end
