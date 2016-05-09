//
//  BCHYelpApi.m
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-06.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <TDOAuth/TDOAuth.h>

#import "BCHYelpApi.h"

@interface BCHYelpCredentials : NSObject

@property (nonatomic, strong) NSString* consumerKey;
@property (nonatomic, strong) NSString* consumerSecret;
@property (nonatomic, strong) NSString* token;
@property (nonatomic, strong) NSString* tokenSecret;

@end

@implementation BCHYelpCredentials

@end

@interface BCHYelpApi()

@property (nonatomic, strong) BCHYelpCredentials* credentials;

@end

@implementation BCHYelpApi

-(BCHYelpCredentials*) credentials {
    if (_credentials == nil) {
        NSDictionary* plist = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Yelp" ofType:@"plist"]];
        _credentials = [BCHYelpCredentials new];
        _credentials.consumerKey = [plist objectForKey:@"YELP_CONSUMER_KEY"];
        _credentials.consumerSecret = [plist objectForKey:@"YELP_CONSUMER_SECRET"];
        _credentials.token = [plist objectForKey:@"YELP_TOKEN"];
        _credentials.tokenSecret = [plist objectForKey:@"YELP_TOKEN_SECRET"];
        
    }
    return _credentials;
}


// create an OAuth request for searching...
-(NSURLRequest*) search:(NSString*) searchTerm limit:(NSUInteger) limit {
    
    NSDictionary *params = @{
                             @"term": searchTerm,
                             @"ll": @"43.648937,-79.3891967",
                             @"limit": [[NSNumber numberWithUnsignedInteger:limit] stringValue],
                             @"category_filter": @"restaurants"
                             };
    return [TDOAuth URLRequestForPath:@"/v2/search/"
                        GETParameters:params
                               scheme:@"https"
                                 host:@"api.yelp.com"
                          consumerKey:self.credentials.consumerKey
                       consumerSecret:self.credentials.consumerSecret
                          accessToken:self.credentials.token
                          tokenSecret:self.credentials.tokenSecret];
}


@end
