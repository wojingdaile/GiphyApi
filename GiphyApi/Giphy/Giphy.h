//
//  Giphy.h
//  Giphy
//
//  Created by alexchoi on 8/18/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GiphyImage.h"
#import "GiphyPagination.h"
#import "../PINCache/PINCache.h"

/** Representation of Giphy's animated GIF and its metadata */
@interface Giphy : NSObject
/** Giphy ID for this GIF */
@property (readonly, strong, nonatomic) NSString * gifID;
@property (readonly, strong, nonatomic) NSString * type;
/** URL to Giphy page for this GIF */
@property (readonly, strong, nonatomic) NSURL * url;
/** Shortened link to Giphy page for this GIF */
@property (readonly, strong, nonatomic) NSURL * bitlyURL;
/** Shortened link to Giphy page for this GIF */
@property (readonly, strong, nonatomic) NSURL * bitlyGIFURL;
@property (readonly, strong, nonatomic) NSURL * embedURL;
@property (readonly, strong, nonatomic) NSURL * contentURL;
@property (readonly, strong, nonatomic) NSString * username;
@property (readonly, strong, nonatomic) NSURL * source;
@property (readonly, strong, nonatomic) NSString * rating;
@property (readonly, strong, nonatomic) NSString * caption;
@property (readonly, strong, nonatomic) NSDate * import_datetime;
@property (readonly, strong, nonatomic) NSDate * trendingDateTime;
@property (readonly, strong, nonatomic) GiphyImage *fixedHeightImage;
@property (readonly, strong, nonatomic) GiphyImage *fixedHeightStillImage;
@property (readonly, strong, nonatomic) GiphyImage *fixedHeightDownSampledImage;
@property (readonly, strong, nonatomic) GiphyImage *fixedWidthImage;
@property (readonly, strong, nonatomic) GiphyImage *fixedWidthStillImage;
@property (readonly, strong, nonatomic) GiphyImage *fixedWidthDownsampledImage;
@property (readonly, strong, nonatomic) GiphyImage *fixedHeightSmallImage;
@property (readonly, strong, nonatomic) GiphyImage *fixedHeightSmallStillImage;
@property (readonly, strong, nonatomic) GiphyImage *fixedWidthSmallImage;
@property (readonly, strong, nonatomic) GiphyImage *fixedWidthSmallStillImage;
@property (readonly, strong, nonatomic) GiphyImage *downsizedImage;
@property (readonly, strong, nonatomic) GiphyImage *downsizedStillImage;
@property (readonly, strong, nonatomic) GiphyImage *downsizedLarge;
@property (readonly, strong, nonatomic) GiphyImage *orignal;
@property (readonly, strong, nonatomic) GiphyImage *orignalStill;


/** Set your Giphy API Key. You must set this before making any requests. You may use kGiphyPublicAPIKey for development
 https://github.com/giphy/GiphyAPI#access-and-api-keys */
+ (void) setGiphyAPIKey:(NSString *) APIkey;
/** Get your currently set Giphy API Key */
+ (NSString *) giphyAPIKey;
/** NSURLRequest to search Giphy with term. You can limit results, with a max of 100. Returns 25 by default. Use offset with limit to paginate through results. */
+ (NSURLRequest *) giphySearchRequestForTerm:(NSString *) term limit:(NSUInteger) limit offset:(NSInteger) offset;
/** NSURLRequest to get trending GIFs. You can limit results, with a max of 100. Returns 25 by default. Use offset with limit to paginate through results. */
+ (NSURLRequest *) giphyTrendingRequestWithLimit:(NSUInteger) limit offset:(NSUInteger) offset;
/** NSURLRequest to fetch GIF with ID .*/
+ (NSURLRequest *) giphyRequestForGIFWithID:(NSString *) ID;
/** NSURLRequest to fetch GIFs with IDs .*/
+ (NSURLRequest *) giphyRequestForGIFsWithIDs:(NSArray *) IDs;
/** NSURLRequest to translate term into a GIF.*/
+ (NSURLRequest *) giphyTranslationRequestForTerm:(NSString *) term;


/** Search Giphy with term. You can limit results, with a max of 100. Returns 25 by default. Use offset with limit to paginate through results. Asynchronously returns either array of Giphy objects or an error. */
+ (NSURLSessionDataTask *) searchGiphyWithTerm:(NSString *) searchTerm limit:(NSUInteger) limit offset:(NSUInteger) offset completion:(void (^) (NSArray * results, GiphyPagination * pagination, NSError * error)) block;
/** Get currently trending GIFs. You can limit results, with a max of 100. Returns 25 by default. Use offset with limit to paginate through results. Asynchronously returns either array of Giphy objects or an error. */
+ (NSURLSessionDataTask *) trendingGIFsWithlimit:(NSUInteger) limit offset:(NSInteger) offset completion:(void (^) (NSArray * results, GiphyPagination * pagination, NSError * error)) block;
/** Fetch GIF with ID . Asynchronously returns either Giphy object or an error.*/
+ (NSURLSessionDataTask *) gifForID:(NSString *) ID completion:(void (^) (Giphy * result, NSError * error)) block;
/** Fetch multiple GIFs by ID. Asynchronously returns either array of Giphy objects or an error.*/
+ (NSURLSessionDataTask *) gifsForIDs:(NSArray *) IDs completion:(void (^) (NSArray * results, GiphyPagination * pagination, NSError * error)) block;
/** Use Giphy's translation 'special sauce' to translate your term into a GIF. Asynchronously returns either Giphy object or an error. */
+ (NSURLSessionDataTask *) giphyTranslationForTerm:(NSString *) term completion:(void (^) (Giphy * result, NSError * error)) block;

/**
 * block api
 */
+ (NSArray *) searchGiphyWithTerm:(NSString*) searchTerm limit:(NSUInteger) limit;

@end
