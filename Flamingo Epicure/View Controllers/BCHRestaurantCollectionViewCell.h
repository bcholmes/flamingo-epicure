//
//  BCHRestaurantCollectionViewCell.h
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-06.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BCHRestaurant.h"

@interface BCHRestaurantCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView* imageView;
@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UILabel* addressLabel;
@property (nonatomic, weak) IBOutlet UILabel* ratingLabel;

-(void) populateFrom:(BCHRestaurant*) restaurant;

@end
