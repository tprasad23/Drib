//
//  ArtistDetail.h
//  Dribbble
//
//  Created by Teju Prasad on 2/8/13.
//  Copyright (c) 2013 Teju Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtistDetail : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSNumber *shotsCount;
@property (nonatomic, strong) NSNumber *likesCount;
@property (nonatomic, strong) NSNumber *followersCount;
@property (nonatomic, strong) NSString *twitterScreenName;

@end
