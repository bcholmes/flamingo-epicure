//
//  BCHYelpService.m
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-04.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import "BCHYelpService.h"
#import "BCHYelpApi.h"
#import "BCHRestaurant.h"

#define SEARCH_LIMIT 10

@implementation BCHYelpService

-(void) findRestaurants:(NSString *)searchTerm completion:(void (^)(NSError* error, NSArray* restaurants)) callback {
    BCHYelpApi* api = [BCHYelpApi new];
    [self processRequest:[api search:searchTerm limit:SEARCH_LIMIT] callback:^(NSError* error, NSData* data) {
        if (callback == nil) {
            // skip it
        } else if (error) {
            callback(error, nil);
        } else {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            callback(nil, [BCHRestaurant fromJsonList:[json objectForKey:@"businesses"]]);
        }
    }];
}

- (void) processRequest:(NSURLRequest*) request callback:(void(^)(NSError* error, NSData* data)) callback {
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* connectionError) {
        
        if (connectionError && [connectionError.domain isEqualToString:NSURLErrorDomain] && connectionError.code == NSURLErrorUserCancelledAuthentication) {
            callback([[NSError alloc] initWithDomain:kErrorHttpDomain code:401 userInfo:nil], nil);
        } else if (connectionError) {
            callback(connectionError, nil);
        } else {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*) response;
            if (httpResponse.statusCode >= 200 || httpResponse.statusCode < 300) {
                callback(nil, data);
            } else {
                callback([[NSError alloc] initWithDomain:kErrorHttpDomain code:httpResponse.statusCode userInfo:nil], nil);
            }
        }
    }];
    [task resume];
}

@end
