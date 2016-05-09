//
//  BCHSearchResultsViewController.h
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-06.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCHRestaurant.h"

@protocol BCHRestaurantDetailsHandler <NSObject>

-(void) openDetailsForRestaurant:(BCHRestaurant*) restaurant;

@end

@interface BCHSearchResultsViewController : UIViewController

@property (nonatomic, strong) NSArray* searchResults;

@property (nonatomic, weak) NSObject<BCHRestaurantDetailsHandler>* detailsHandler;

-(void) refresh;

@end
