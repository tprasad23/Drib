//
//  DribbbleViewController.h
//  Dribble
//
//  Created by Teju Prasad on 2/6/13.
//  Copyright (c) 2013 Teju Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DribbbleViewController : UIViewController <UIGestureRecognizerDelegate>

// View Variables

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIScrollView *theScrollView;
@property(nonatomic, strong) UIView *imageDetailView;

// Image Detail Labels

@property(nonatomic, strong) UILabel *mainLabel;
@property(nonatomic, strong) UILabel *viewsLabel;
@property(nonatomic, strong) UILabel *reboundsLabel;
@property(nonatomic, strong) UILabel *artistNameLabel;
@property(nonatomic, strong) UILabel *artistLocationLabel;
@property(nonatomic, strong) UILabel *artistShotCountLabel;

// Data variables

@property(nonatomic, strong) NSArray *shots;
@property(nonatomic, strong) NSMutableArray *everyoneShots;
@property(nonatomic, strong) NSMutableArray *imageDetailArray;

-(UIImage *) GetImageFromURL:(NSString *)fileURL;
-(void) PopulateImages:(NSArray *)arrayOfImages;


@end


