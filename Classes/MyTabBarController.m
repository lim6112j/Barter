//
//  MyTabBarController.m
//  Barter
//
//  Created by lim byeong cheol on 11. 10. 13..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import "MyTabBarController.h"

@implementation MyTabBarController
@synthesize myTabBar;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)
    {
         NSLog(@"interface orientation == landscape");
        if (
            [[(UINavigationController *)self.selectedViewController visibleViewController] isKindOfClass:[HaveViewController class]]) {
            CoverFlowController *cFC=[[CoverFlowController alloc]init];
            [self.view addSubview:cFC.view];
            [cFC release];
            [self.tabBar setHidden:YES];
          
        }

        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    } else if(interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        NSLog(@"interface orientation == portrait");
        [self.tabBar setHidden:NO];
        for (UIView *view in [self.view subviews]) {
            if ([view tag]==10) {
                [view removeFromSuperview];
            }
        }

        return YES;
    }
	return (interfaceOrientation == UIInterfaceOrientationPortrait);

}

-(void)dealloc
{
    [super dealloc];
}
@end
