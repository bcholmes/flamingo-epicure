//
//  BCHLightboxView.m
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-06.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "BCHLightboxView.h"

@implementation BCHLightboxView

-(void) awakeFromNib {
    self.layer.cornerRadius = 25;
    self.layer.masksToBounds = YES;
}

@end
