//
//  DribbbleViewController.m
//  Dribble
//
//  Created by Teju Prasad on 2/6/13.
//  Copyright (c) 2013 Teju Prasad. All rights reserved.
//


#define kGetShotsURL [NSURL URLWithString:@"http://api.dribbble.com/shots/everyone"]
#define kNumShots 4

#import "DribbbleViewController.h"

@interface DribbbleViewController ()

@end

@implementation DribbbleViewController

@synthesize contentView;
@synthesize shots;
@synthesize shotURLS;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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

- (void) loadView
{
    
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    contentView = [[UIView alloc] initWithFrame:frame];
    
    // set background color
    
    contentView.backgroundColor = [UIColor grayColor];
    
    self.view = contentView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
