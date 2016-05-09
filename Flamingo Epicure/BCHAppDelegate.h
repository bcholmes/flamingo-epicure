//
//  AppDelegate.h
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-04.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCHYelpService.h"

@interface BCHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) BCHYelpService* yelpService;

+(BCHAppDelegate*) instance;

@end

