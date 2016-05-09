//
//  BCHHairlineView.m
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-06.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import "BCHHairlineView.h"

@interface BCHHairlineView()

@property (nonatomic, strong) UIView* separator;

@end

@implementation BCHHairlineView

-(void) layoutSubviews {
    if (self.separator != nil) {
        [self.separator removeFromSuperview];
    }
    
    self.separator = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(self.bounds), CGRectGetWidth(self.bounds), 1)];
    self.separator.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    [self addSubview:self.separator];
}

@end
