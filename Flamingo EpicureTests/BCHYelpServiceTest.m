//
//  BCHYelpServiceTest.m
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-09.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <XCTest/XCTest.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "BCHYelpService.h"


@interface BCHYelpServiceTest : XCTestCase

@end

@implementation BCHYelpServiceTest

- (void)testYelpSearch {
    
    BCHYelpService* service = [BCHYelpService new];
    [service findRestaurants:@"Indian" completion:^(NSError* error, NSArray* restaurants) {
        
        assertThat(error, nilValue());
        assertThat(@(restaurants.count), equalTo(@(10)));
        
    }];
}

@end
