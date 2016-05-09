//
//  BCHYelpApi.h
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-06.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCHYelpApi : NSObject

-(NSURLRequest*) search:(NSString*) searchTerm limit:(NSUInteger) limit;

@end
