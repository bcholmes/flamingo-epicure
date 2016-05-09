//
//  BCHRestaurantTest.m
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-09.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <XCTest/XCTest.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "BCHRestaurant.h"

@interface BCHRestaurantTest : XCTestCase

@end

@implementation BCHRestaurantTest

- (void)testParseJsonList {
    
    NSString* jsonFile = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"yelp.json"];
    NSData* content = [NSData dataWithContentsOfFile:jsonFile];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:nil];
 
    NSArray* restaurants = [BCHRestaurant fromJsonList:[json objectForKey:@"businesses"]];
    assertThat(@(restaurants.count), equalTo(@(10)));
}

- (void)testParseSingleRestaurant {
    
    NSString* jsonFile = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"yelp.json"];
    NSData* content = [NSData dataWithContentsOfFile:jsonFile];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:nil];
    NSArray* jsonList = [json objectForKey:@"businesses"];
    
    BCHRestaurant* restaurant = [BCHRestaurant fromJson:jsonList[0]];
    assertThat(restaurant, notNilValue());
    assertThat(restaurant.name, equalTo(@"Corrado's"));
}

@end
