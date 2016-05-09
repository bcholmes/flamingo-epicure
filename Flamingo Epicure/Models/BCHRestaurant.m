//
//  BCHRestaurant.m
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-04.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import "BCHRestaurant.h"

@implementation BCHRestaurant

+(NSArray*) fromJsonList:(NSArray*) jsonList {
    NSMutableArray* result = [NSMutableArray new];
    for (NSDictionary* json in jsonList) {
        [result addObject:[BCHRestaurant fromJson:json]];
    }
    return [NSArray arrayWithArray:result];
}

+(BCHRestaurant*) fromJson:(NSDictionary*) json {
    BCHRestaurant* result = [BCHRestaurant new];
    result.name = [json objectForKey:@"name"];
    result.phoneNumber = [json objectForKey:@"display_phone"];
    result.city = [json valueForKeyPath:@"location.city"];
    result.address = [json valueForKeyPath:@"location.address"];
    result.imageUrl = [json objectForKey:@"image_url"];
    result.rating = [json objectForKey:@"rating"];
    result.snippetText = [json objectForKey:@"snippet_text"];
    result.snippetUrl = [json objectForKey:@"snippet_image_url"];
    
    return result;
}

-(NSString*) streetAddress {
    return self.address.count > 0 ? self.address[0] : nil;
}

@end
