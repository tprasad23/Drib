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
@synthesize imageDetailView;
@synthesize mainLabel;
@synthesize viewsLabel;
@synthesize reboundsLabel;
@synthesize artistNameLabel;
@synthesize artistLocationLabel;
@synthesize artistShotCountLabel;

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
//    frame = [UIScreen mainScreen].bounds;
    
    float width = frame.size.width;
    float height = frame.size.height;
        
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
    
    // Set Up Image Detail View
    
    frame = CGRectMake(0,kYOffset+170,width,height-270);
    imageDetailView = [[UIView alloc] initWithFrame:frame];
    imageDetailView.backgroundColor = [UIColor blackColor];
    imageDetailView.alpha = .6f;
    imageDetailView.hidden = YES;
    
    frame = CGRectMake(10, 0, width, 20);
    mainLabel = [[UILabel alloc] initWithFrame:frame];
    mainLabel.textColor = [UIColor whiteColor];
    mainLabel.backgroundColor = [UIColor clearColor];
    mainLabel.text = @"Main Label";
    mainLabel.font=[UIFont systemFontOfSize:12.0];

    frame = CGRectMake(10, 20, width, 20);
    viewsLabel = [[UILabel alloc] initWithFrame:frame];
    viewsLabel.textColor = [UIColor whiteColor];
    viewsLabel.backgroundColor = [UIColor clearColor];
    viewsLabel.text = @"Main2 Label";
    viewsLabel.font=[UIFont systemFontOfSize:12.0];

    frame = CGRectMake(10, 40, width, 20);
    reboundsLabel = [[UILabel alloc] initWithFrame:frame];
    reboundsLabel.textColor = [UIColor whiteColor];
    reboundsLabel.backgroundColor = [UIColor clearColor];
    reboundsLabel.text = @"Main3 Label";
    reboundsLabel.font=[UIFont systemFontOfSize:12.0];

    frame = CGRectMake(10, 60, width, 20);
    artistNameLabel = [[UILabel alloc] initWithFrame:frame];
    artistNameLabel.textColor = [UIColor whiteColor];
    artistNameLabel.backgroundColor = [UIColor clearColor];
    artistNameLabel.text = @"Main4 Label";
    artistNameLabel.font=[UIFont systemFontOfSize:12.0];

    frame = CGRectMake(10, 80, width, 20);
    artistLocationLabel = [[UILabel alloc] initWithFrame:frame];
    artistLocationLabel.textColor = [UIColor whiteColor];
    artistLocationLabel.backgroundColor = [UIColor clearColor];
    artistLocationLabel.text = @"Main5 Label";
    artistLocationLabel.font=[UIFont systemFontOfSize:12.0];

    frame = CGRectMake(10, 100, width, 20);
    artistShotCountLabel = [[UILabel alloc] initWithFrame:frame];
    artistShotCountLabel.textColor = [UIColor whiteColor];
    artistShotCountLabel.backgroundColor = [UIColor clearColor];
    artistShotCountLabel.text = @"Main6 Label";
    artistShotCountLabel.font=[UIFont systemFontOfSize:12.0];

    [imageDetailView addSubview:mainLabel];
    [imageDetailView addSubview:viewsLabel];
    [imageDetailView addSubview:reboundsLabel];
    [imageDetailView addSubview:artistNameLabel];
    [imageDetailView addSubview:artistLocationLabel];
    [imageDetailView addSubview:artistShotCountLabel];
    
    [contentView addSubview:theScrollView];
    [contentView addSubview:imageDetailView];
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
    
    [self updateImageDetailView:tempImageDetail];
    
}

- (void)updateImageDetailView:(ImageDetail *)imageDetail
{
    // update the image detail view
    
    NSString *mainLabelString = [NSString stringWithFormat:@"Image Title: %@",imageDetail.title];
    NSString *viewsLabelString = [NSString stringWithFormat:@"Views: %@",imageDetail.viewsCount];
    NSString *reboundsLabelString = [NSString stringWithFormat:@"Rebounds: %@",imageDetail.reboundsCount];
    NSString *artistNameLabelString =
            [NSString stringWithFormat:@"Artist Name: %@",imageDetail.artistName];
    NSString *artistLocationLabelString =
            [NSString stringWithFormat:@"Location: %@",imageDetail.artistLocation];
    NSString *artistShotCountLabelString =
            [NSString stringWithFormat:@"Shot Count: %@",imageDetail.artistShotsCount];
    
    mainLabel.text = mainLabelString;
    viewsLabel.text = viewsLabelString;
    reboundsLabel.text = reboundsLabelString;
    artistNameLabel.text = artistNameLabelString;
    artistLocationLabel.text = artistLocationLabelString;
    artistShotCountLabel.text = artistShotCountLabelString;

    if ( imageDetailView.hidden == YES )
    {
        imageDetailView.hidden = NO;
    }
    
}


@end
