//
//  DribbbleViewController.m
//  Dribble
//
//  Created by Teju Prasad on 2/6/13.
//  Copyright (c) 2013 Teju Prasad. All rights reserved.
//


#define kGetShotsURL [NSURL URLWithString:@"http://api.dribbble.com/shots/everyone"]
#define kNumShots 4
#define kImgWidth 200
#define kImgHeight 150
#define kYOffset 70

#import "DribbbleViewController.h"
#import "ImageDetail.h"

@interface DribbbleViewController ()

@end

@implementation DribbbleViewController

@synthesize contentView;
@synthesize shots;
@synthesize theScrollView;
@synthesize everyoneShots;
@synthesize imageDetailArray;


- (id) init
{
    self = [super init];
    
    if (self)
    {
        // Custom initialization - label text for audio and video content
        
        NSLog(@"Calling init");
    
        NSData *jsonData = [NSData dataWithContentsOfURL:kGetShotsURL];
        NSError *error = nil;
        
        if ( jsonData )
        {
            id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
            
            if (error)
            {
                NSLog(@"error is %@", [error localizedDescription]);
            }
            else
            {
                // Load image URLS into array.
                
                imageDetailArray = [[NSMutableArray alloc] init];
                
                NSArray *allShots = [jsonObjects objectForKey:@"shots"];
                int i;
                
                // Only display a preset number of shots
                
                for (i = 0; i < kNumShots; i++)
                {
                    // allocate temp image detail
                    
                    ImageDetail *tempImageDetail = [[ImageDetail alloc] init];
                    
                    // get data from larger json object
                    
                    NSDictionary *tempShot = [allShots objectAtIndex:i];
                    NSDictionary *tempArtist = [tempShot valueForKey:@"player"];
                    
                    // populate temp image detail object
                    
                    tempImageDetail.title = [tempShot valueForKey:@"title"];
                    tempImageDetail.imageURL = [tempShot valueForKey:@"image_url"];
                    tempImageDetail.viewsCount = [tempShot valueForKey:@"views_count"];
                    tempImageDetail.reboundsCount = [tempShot valueForKey:@"rebounds_count"];
                    tempImageDetail.artistName = [tempArtist valueForKey:@"name"];
                    tempImageDetail.artistLocation = [tempArtist valueForKey:@"location"];
                    tempImageDetail.artistShotsCount = [tempArtist valueForKey:@"shots_count"];
                    [imageDetailArray addObject:tempImageDetail];
                    
                }
                
            }
            
        }
        else
        {
            NSLog(@"error in retrieving the JSON data");
        }
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Calling view Did Load");
    
}

- (void) loadView
{
    NSLog(@"calling LoadView");
    
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    contentView = [[UIView alloc] initWithFrame:frame];
    frame = [UIScreen mainScreen].bounds;
    
    float width = frame.size.width;
        
    // set background color
    
    contentView.backgroundColor = [UIColor grayColor];
    
    // Create Scroll View frame and content size based on # of images to present.
    
    int i;
    int numPresentedImgs = [imageDetailArray count];
    frame = CGRectMake(0,kYOffset,width,kImgHeight);
    theScrollView = [[UIScrollView alloc] initWithFrame:frame];
    theScrollView.contentSize = CGSizeMake(numPresentedImgs * kImgWidth, kImgHeight);

    // Load the Images into the Image Array.
    
    everyoneShots = [[NSMutableArray alloc] init];
    for ( i = 0; i < numPresentedImgs; i++)
    {
        UIImage *tmpImage = [[UIImage alloc] init];
        ImageDetail *tempImageDetail = [imageDetailArray objectAtIndex:i];
        
        tmpImage = [self GetImageFromURL:tempImageDetail.imageURL];
        [everyoneShots addObject:tmpImage];
    }

    // Add the Images from the array into Scroll View.
    
    [self PopulateImages:everyoneShots];
    
    [contentView addSubview:theScrollView];
    self.view = contentView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark image loading methods

// Provide this method an array of UIImages

-(void) PopulateImages:(NSArray *)arrayOfImages {
    
    NSArray *subviews = [theScrollView subviews];
    int numSubviews = [subviews count];
    int numImages = [arrayOfImages count];
    
    if ( numSubviews == 0)
    {
        // must allocate the subviews
        
        int i = 0;
        UIImage *shotToPresent;
        for ( shotToPresent in arrayOfImages )
        {
            UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:shotToPresent];
            [tmpImageView setFrame:CGRectMake(i*kImgWidth, 0, kImgWidth, kImgHeight)];
            tmpImageView.userInteractionEnabled = YES;
            tmpImageView.tag = 1000 + i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
            [tmpImageView addGestureRecognizer:tap];
            
            i++;
            [theScrollView addSubview:tmpImageView];
        }
    }
}

-(UIImage *) GetImageFromURL:(NSString *)fileURL {
    
    UIImage *result;
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

- (void)imageTapped:(UIGestureRecognizer *)sender
{
    NSLog(@"imageTapped");

    UIImageView *imageView = (UIImageView *)[sender view];
    NSInteger index = imageView.tag - 1000;
    
    ImageDetail *tempImageDetail = [imageDetailArray objectAtIndex:index];
    
    NSLog(@"title is %@",tempImageDetail.title);
    NSLog(@"views count is %@",tempImageDetail.viewsCount);
    NSLog(@"artist name is %@",tempImageDetail.artistName);
    
}

@end
