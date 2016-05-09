//
//  BCHRestaurantCollectionViewCell.m
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-06.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import "BCHRestaurantCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation BCHRestaurantCollectionViewCell

-(void) populateFrom:(BCHRestaurant*) record {
    self.nameLabel.text = record.name;
    self.addressLabel.text = record.streetAddress;
    self.ratingLabel.text = [record.rating stringValue];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:record.imageUrl] placeholderImage:[UIImage imageNamed:@"restaurant"]];
    
}

@end
