//
//  BCHYelpService.h
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-04.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kErrorHttpDomain @"ca.intelliware.flamingoepicure.http"

@interface BCHYelpService : NSObject

-(void) findRestaurants:(NSString*) searchTerm completion:(void (^)(NSError* error, NSArray* restaurants)) completion;

@end
