//
//  DribbbleViewController.h
//  Dribble
//
//  Created by Teju Prasad on 2/6/13.
//  Copyright (c) 2013 Teju Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DribbbleViewController : UIViewController <UIGestureRecognizerDelegate>

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) NSArray *shots;
@property(nonatomic, strong) NSMutableArray *presentedShots;
@property(nonatomic, strong) NSMutableArray *shotURLS;
@property(nonatomic, strong) UIScrollView *theScrollView;

-(UIImage *) GetImageFromURL:(NSString *)fileURL;

@end


