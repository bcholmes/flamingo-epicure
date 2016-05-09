//
//  BCHSearchResultsViewController.m
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-06.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import "BCHSearchResultsViewController.h"

#import "BCHRestaurantCollectionViewCell.h"

#define SECTION_INSETS 20
#define CELL_SPACING 20

@interface BCHSearchResultsViewController()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel* noResultsMessage;
@property (nonatomic, weak) IBOutlet UICollectionView* collectionView;

@end

@implementation BCHSearchResultsViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

-(void) refresh {
    [self.collectionView reloadData];
    self.noResultsMessage.hidden = (self.searchResults.count > 0);
}


#pragma mark - UICollectionViewDataSource

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView*) collectionView cellForItemAtIndexPath:(NSIndexPath*) indexPath {
    
    BCHRestaurantCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"restaurantCell" forIndexPath:indexPath];
    [cell populateFrom:self.searchResults[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(self.view.frame) - 2 * SECTION_INSETS - CELL_SPACING;
    NSLog(@"width %f", width / 2.0);
    return CGSizeMake(width / 2.0 , width / 2.0);
}

-(void) collectionView:(UICollectionView*) collectionView didSelectItemAtIndexPath:(NSIndexPath*) indexPath {
    BCHRestaurant* record = self.searchResults[indexPath.row];
    [self.detailsHandler openDetailsForRestaurant:record];
}

@end
