//
//  DribbbleViewController.m
//  Dribble
//
//  Created by Teju Prasad on 2/6/13.
//  Copyright (c) 2013 Teju Prasad. All rights reserved.
//

#import "DribbbleViewController.h"

@interface DribbbleViewController ()

@end

@implementation DribbbleViewController

@synthesize contentView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) loadView
{
    
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    contentView = [[UIView alloc] initWithFrame:frame];
    
    // set background to green
    
    contentView.backgroundColor = [UIColor greenColor];
    
    self.view = contentView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
