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

@interface DribbbleViewController ()

@end

@implementation DribbbleViewController

@synthesize contentView;
@synthesize shots;
@synthesize shotURLS;
@synthesize theScrollView;
@synthesize presentedShots;


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
                
                shotURLS = [[NSMutableArray alloc] init];
                
                NSArray *allShots = [jsonObjects objectForKey:@"shots"];
                int i;
                
                for (i = 0; i < kNumShots; i++)
                {
                    // get image URL from temporary shot
                    
                    NSDictionary *tempShot = [allShots objectAtIndex:i];
                    NSString *imgURL = [tempShot valueForKey:@"image_url"];
                    
                    [shotURLS addObject:imgURL];
                    
                    NSLog(@"image url is %@",imgURL);
                }
                
                int numToShow = [shotURLS count];
                NSLog(@"showing %d these many shots",numToShow);
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
    int numPresentedImgs = [shotURLS count];
    frame = CGRectMake(0,kYOffset,width,kImgHeight);
    theScrollView = [[UIScrollView alloc] initWithFrame:frame];
    theScrollView.contentSize = CGSizeMake(numPresentedImgs * kImgWidth, kImgHeight);

    // Load the Images into the Image Array.
    
    presentedShots = [[NSMutableArray alloc] init];
    for ( i = 0; i < numPresentedImgs; i++)
    {
        UIImage *tmpImage = [[UIImage alloc] init];
        tmpImage = [self GetImageFromURL:[shotURLS objectAtIndex:i]];
        [presentedShots addObject:tmpImage];
    }

    // Add the Images from the array into Scroll View.
    
    i = 0;
    UIImage *shotToPresent;
    for ( shotToPresent in presentedShots )
    {
        UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:shotToPresent];
        [tmpImageView setFrame:CGRectMake(i*kImgWidth, 0, kImgWidth, kImgHeight)];
        tmpImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        [tmpImageView addGestureRecognizer:tap];
        
        i++;
        [theScrollView addSubview:tmpImageView];
    }
    
    [contentView addSubview:theScrollView];
    self.view = contentView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    // how to get reference on selected item in scrollview???
}

@end
