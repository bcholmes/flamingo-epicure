//
//  ViewController.m
//  Flamingo Epicure
//
//  Created by BC Holmes on 2016-05-04.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "BCHRestaurantListViewController.h"

#import "BCHRestaurantCollectionViewCell.h"
#import "BCHRestaurantDetailViewController.h"
#import "BCHYelpService.h"
#import "BCHAppDelegate.h"
#import "BCHRestaurant.h"
#import "BCHSearchResultsViewController.h"

#define SECTION_INSETS 20
#define CELL_SPACING 20

typedef enum {
    BCHSortByRating,
    BCHSortByName
} BCHSortType;

@interface BCHRestaurantListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, BCHRestaurantDetailsHandler>

@property (nonatomic, weak) IBOutlet UICollectionView* collectionView;
@property (nonatomic, weak) IBOutlet UIButton* sortButton;
@property (nonatomic, weak) IBOutlet UILabel* noResultsMessage;

@property (nonatomic, strong) UISearchController* searchController;
@property (nonatomic, strong) NSTimer* searchTimer;
@property (nonatomic, strong) BCHYelpService* yelpService;
@property (nonatomic, strong) NSArray* restaurantList;
@property (nonatomic, assign) BCHSortType currentSortType;

@end

@implementation BCHRestaurantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self loadRestaurants:@""];
    self.currentSortType = BCHSortByRating;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BCHYelpService*) yelpService {
    if (_yelpService == nil) {
        _yelpService = [BCHAppDelegate instance].yelpService;
    }
    return _yelpService;
}

- (UISearchController*) searchController {
    
    if (!_searchController) {
        BCHSearchResultsViewController* resultsController = [self.storyboard instantiateViewControllerWithIdentifier:@"searchResults"];
        resultsController.detailsHandler = self;
        
        _searchController = [[UISearchController alloc]initWithSearchResultsController:resultsController];
        _searchController.searchResultsUpdater = self;
        
        _searchController.delegate = self;
    }
    return _searchController;
}


- (IBAction)searchButtonPressed:(id)sender {
    [self presentViewController:self.searchController animated:YES completion:nil];
}

- (void) didDismissSearchController:(UISearchController*) searchController {
}

-(void) loadRestaurants:(NSString*) searchTerm {
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self.yelpService findRestaurants:searchTerm completion:^(NSError* error, NSArray* resturants) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
                if (error) {
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error connecting to Yelp"
                                                                                   message:error.localizedDescription
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction * action) {
                                                            }]];
                    [self presentViewController:alert animated:YES completion:nil];
                } else {
                
                    self.restaurantList = resturants;
                    [self sortAndReloadCollectionView:self.currentSortType];
                }
            });
        }];
    });
    
}

-(void) showDetailView:(BCHRestaurant*) restaurant {
    BCHRestaurantDetailViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    controller.restaurant = restaurant;
    
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(NSArray*) sortRestaurants:(NSArray*) restaurants sortType:(BCHSortType) sortType {
    if (sortType == BCHSortByName) {
        return [restaurants sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString* first = [(BCHRestaurant*)a name];
            NSString* second = [(BCHRestaurant*)b name];
            return [first compare:second];
        }];
    } else {
        return [restaurants sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSNumber* first = [(BCHRestaurant*)a rating];
            NSNumber* second = [(BCHRestaurant*)b rating];
            return [second compare:first];
        }];
    }
}

-(void) sortAndReloadCollectionView:(BCHSortType) sortType {
    self.restaurantList = [self sortRestaurants:self.restaurantList sortType:sortType];
    self.currentSortType = sortType;
    [self.collectionView reloadData];
    
    if (sortType == BCHSortByRating) {
        self.sortButton.titleLabel.text = @"sorted by rating";
    } else {
        self.sortButton.titleLabel.text = @"sorted by name";
    }
}

#pragma mark - UICollectionViewDataSource

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.restaurantList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(self.view.frame) - 2 * SECTION_INSETS - CELL_SPACING;
    return CGSizeMake(width / 2.0 , width / 2.0);
}

- (UICollectionViewCell*) collectionView:(UICollectionView*) collectionView cellForItemAtIndexPath:(NSIndexPath*) indexPath {
    
    BCHRestaurantCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"restaurantCell" forIndexPath:indexPath];
    [cell populateFrom:self.restaurantList[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

-(void) collectionView:(UICollectionView*) collectionView didSelectItemAtIndexPath:(NSIndexPath*) indexPath {
    BCHRestaurant* record = self.restaurantList[indexPath.row];
    [self showDetailView:record];
}

- (IBAction) chooseSortOption:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Sort by rating" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self sortAndReloadCollectionView:BCHSortByRating];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Sort by name" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self sortAndReloadCollectionView:BCHSortByName];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - UISearchResultsUpdating protocol

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (self.searchTimer.isValid) {
        [self.searchTimer invalidate];
        self.searchTimer = nil;
    }
    NSString* searchText = searchController.searchBar.text;
    if (searchText.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.searchTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(performSearch:) userInfo:searchText repeats:NO];
        });
    }
}

-(void) performSearch:(NSTimer*) timer {
    NSString* searchText = timer.userInfo;
    NSLog(@"Search text: %@", searchText);
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self.yelpService findRestaurants:searchText completion:^(NSError* error, NSArray* resturants) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
                if (error) {
                } else {
                    BCHSearchResultsViewController* controller = (BCHSearchResultsViewController*) self.searchController.searchResultsController;
                    controller.searchResults = self.restaurantList = [self sortRestaurants:resturants sortType:self.currentSortType];
                    [self.collectionView reloadData];
                    [controller refresh];
                }
            });
        }];
    });
}

-(void) openDetailsForRestaurant:(BCHRestaurant*) restaurant {
    [self.searchController setActive:NO];
    [self showDetailView:restaurant];
}

@end
