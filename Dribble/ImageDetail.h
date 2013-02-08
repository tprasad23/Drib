//
//  ImageDetail.h
//  Dribbble
//
//  Created by Teju Prasad on 2/8/13.
//  Copyright (c) 2013 Teju Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDetail : NSObject{
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSNumber *viewsCount;
@property (nonatomic, strong) NSNumber *reboundsCount;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSNumber *artistId;
@property (nonatomic, strong) NSString *artistLocation;
@property (nonatomic, strong) NSNumber *artistShotsCount;

@end
