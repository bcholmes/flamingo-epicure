//
//  BCHRestaurant.h
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-04.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCHRestaurant : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSArray* address;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* phoneNumber;
@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) NSNumber* rating;
@property (nonatomic, strong) NSString* snippetText;
@property (nonatomic, strong) NSString* snippetUrl;

@property (nonatomic, readonly) NSString* streetAddress;

+(NSArray*) fromJsonList:(NSArray*) jsonList;
+(BCHRestaurant*) fromJson:(NSDictionary*) json;

@end
