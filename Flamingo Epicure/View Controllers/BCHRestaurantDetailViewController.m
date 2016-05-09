//
//  BCHRestaurantDetailViewController.m
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-06.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "BCHRestaurantDetailViewController.h"

@interface BCHRestaurantDetailViewController()

@property (nonatomic, weak) IBOutlet UIImageView* imageView;
@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UILabel* addressLabel;
@property (nonatomic, weak) IBOutlet UILabel* phoneNumberLabel;

@property (nonatomic, weak) IBOutlet UILabel* snippetLabel;
@property (nonatomic, weak) IBOutlet UIImageView* snippetImageView;

@end


@implementation BCHRestaurantDetailViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.restaurant.name;
    self.phoneNumberLabel.text = self.restaurant.phoneNumber;
    self.addressLabel.text = self.restaurant.streetAddress;
    self.snippetLabel.text = self.restaurant.snippetText;
    
    self.snippetImageView.layer.cornerRadius = 5;
    self.snippetImageView.layer.masksToBounds = YES;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.restaurant.imageUrl] placeholderImage:[UIImage imageNamed:@"restaurant"]];
    [self.snippetImageView sd_setImageWithURL:[NSURL URLWithString:self.restaurant.snippetUrl] placeholderImage:[UIImage imageNamed:@"restaurant"]];
}

-(IBAction) close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
