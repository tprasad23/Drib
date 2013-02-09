//
//  DribbbleViewController.h
//  Dribble
//
//  Created by Teju Prasad on 2/6/13.
//  Copyright (c) 2013 Teju Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtistDetail.h"
#import "ImageDetail.h"

@interface DribbbleViewController : UIViewController <UIGestureRecognizerDelegate>

// View Variables

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIScrollView *theScrollView;
@property(nonatomic, strong) UIView *imageDetailView;
@property(nonatomic, strong) UIView *artistDetailView;

// Image Detail Labels

@property(nonatomic, strong) UILabel *mainLabel;
@property(nonatomic, strong) UILabel *viewsLabel;
@property(nonatomic, strong) UILabel *reboundsLabel;
@property(nonatomic, strong) UILabel *artistNameLabel;
@property(nonatomic, strong) UIButton *artistNameButton;
@property(nonatomic, strong) UILabel *artistLocationLabel;
@property(nonatomic, strong) UILabel *artistShotCountLabel;

// Artist Detail Labels

@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *locationLabel;
@property(nonatomic, strong) UILabel *shotsCountLabel;
@property(nonatomic, strong) UILabel *likesCountLabel;
@property(nonatomic, strong) UILabel *followersCountLabel;
@property(nonatomic, strong) UILabel *twitterScreenNameLabel;
@property(nonatomic, strong) UIButton *dismissButton;

// Data variables

@property(nonatomic, strong) NSArray *shots;
@property(nonatomic, strong) NSMutableArray *everyoneShots;
@property(nonatomic, strong) NSMutableArray *imageDetailArray;

-(UIImage *) GetImageFromURL:(NSString *)fileURL;
-(void) PopulateImages:(NSArray *)arrayOfImages;
-(void) ArtistButtonPressed:(UIButton *)btn;
- (void) DismissButtonPressed:(UIButton*)btn;
-(void) LoadArtistData:(NSInteger)artistId;
- (void)updateArtistDetailView:(ArtistDetail *)artistDetail;
- (void)updateImageDetailView:(ImageDetail *)imageDetail;

@end


